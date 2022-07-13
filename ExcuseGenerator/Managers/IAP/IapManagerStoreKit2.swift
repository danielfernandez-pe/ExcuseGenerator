//
//  IapManagerStoreKit2.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 12.07.2022.
//

import Foundation
import StoreKit
import Combine

@available(iOS 15, *)
enum IAPPurchaseFetchResultSk2 {
    case empty
    case fetched(products: [Product])
    case error(error: Error)
}

@available(iOS 15, *)
enum IAPPurchaseErrorSk2: Error {
    case failedVerification
}

@available(iOS 15, *)
protocol IapManagerTypeSk2: IapManagerUserPremium {
    var canMakePayments: Bool { get }

    func getProducts() async -> [Product]
    func buyProduct(_ product: Product) async throws
    func isPurchased(_ product: Product) async -> Bool
    func restorePurchases()
    func getLatestTransactions() async -> [Transaction]
}

@available(iOS 15, *)
final class IapManagerStoreKit2: IapManagerTypeSk2 {
    var canMakePayments: Bool {
        SKPaymentQueue.canMakePayments()
    }

    var isUserPremium: AnyPublisher<Bool, Never> {
        isUserPremiumSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private let isUserPremiumSubject = CurrentValueSubject<Bool, Never>(false)
    private var purchasedProductIds: Set<String> = []
    private var updates: Task<Void, Never>?

    init() {
        updates = listenForTransactions()

        Task {
            await handleProactiveRestore()
        }
    }

    deinit {
        updates?.cancel()
    }

    @MainActor
    func getProducts() async -> [Product] {
        do {
            let products = try await Product.products(for: IapManager.availableProductIds)
            return products
        } catch {
            print("Failed product request: \(error)")
            return []
        }
    }

    func buyProduct(_ product: Product) async throws {
        let result = try await product.purchase()
        switch result {
        case .success(let verification):
            // transaction verification already done by Apple
            let transaction = try checkVerified(verification)
            await handlePurchasedProduct(with: transaction)
            await transaction.finish()
        case .userCancelled:
            print("do nothing")
        case .pending:
            print("Parent approval, deferred")
        @unknown default:
            assertionFailure("Handle new cases")
        }
    }

    func restorePurchases() {
        // Transaction.currentEntitlements
    }

    func isPurchased(_ product: Product) async -> Bool {
        // MARK: First way, if you use Transaction.currentEntitlements

        purchasedProductIds.contains(product.id)

        // MARK: Second way

//        guard let result = await Transaction.latest(for: product.id) else {
//            return false
//        }
//        do {
//            let transaction = try checkVerified(result)
//            return transaction.revocationDate == nil && !transaction.isUpgraded
//        } catch {
//            return false
//        }
    }

    func handlePurchasedProduct(with transaction: Transaction) async {
        purchasedProductIds.insert(transaction.productID)

        if transaction.productType == .autoRenewable, let expirationDate = transaction.expirationDate {
            let isUserPremium = expirationDate > .now
            isUserPremiumSubject.send(isUserPremium)
        }
    }

    func getLatestTransactions() async -> [Transaction] {
        var transactions: [Transaction] = []

        for purchasedProductId in purchasedProductIds {
            guard let result = await Transaction.latest(for: purchasedProductId) else { continue }
            do {
                let transaction = try checkVerified(result)
                transactions.append(transaction)
            } catch {}
        }

        return transactions
    }

    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw IAPPurchaseErrorSk2.failedVerification
        case .verified(let safe):
            return safe
        }
    }

    private func listenForTransactions() -> Task<Void, Never> {
        Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    print("New update for transaction with \(transaction.productID)")

                    // MARK: - Handle refund

                    if let revocationDate = transaction.revocationDate, let revocationReason = transaction.revocationReason {
                        print("\(transaction.productID) revoked on \(revocationDate)")

                        switch revocationReason {
                        case .developerIssue:
                            print("Handle one way")
                        case .other:
                            print("Handle another way")
                        default:
                            break
                        }

                        self.purchasedProductIds.remove(transaction.productID)
                        if transaction.productType == .autoRenewable {
                            self.isUserPremiumSubject.send(false)
                        }
                    } else {
                        // MARK: - Handle purchase

                        await self.handlePurchasedProduct(with: transaction)
                    }

                    await transaction.finish()
                } catch {
                    // ignore unverified transactions
                }
            }
        }
    }

    // finite stream
    private func handleProactiveRestore() async {
        // currentEntitlements work for non-consumable and subscriptions.
        // consumable won't appear here because it can be purchase multiple times
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try self.checkVerified(result)
                print("Current entitlements has transaction for \(transaction.productID)")
                if transaction.revocationDate == nil {
                    switch transaction.productType {
                    case .autoRenewable:
                        if let expirationDate = transaction.expirationDate, expirationDate > .now {
                            isUserPremiumSubject.send(true)
                            purchasedProductIds.insert(transaction.productID)
                        }
                    case .nonConsumable:
                        purchasedProductIds.insert(transaction.productID)
                    default:
                        break
                    }
                } else {
                    purchasedProductIds.remove(transaction.productID)
                }
            } catch {
                // ignore unverified transactions
            }
        }
    }
}
