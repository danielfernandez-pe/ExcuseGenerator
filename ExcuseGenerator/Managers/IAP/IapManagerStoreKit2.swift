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
protocol IapManagerTypeSk2 {
    var canMakePayments: Bool { get }
    var isUserPremium: AnyPublisher<Bool, Never> { get }

    func getProducts() async -> [Product]
    func buyProduct(_ product: Product) async throws
    func isPurchased(_ product: Product) async -> Bool
    func restorePurchases()
}

@available(iOS 15, *)
final class IapManagerStoreKit2: IapManagerTypeSk2 {
    var canMakePayments: Bool {
        SKPaymentQueue.canMakePayments()
    }

    var isUserPremium: AnyPublisher<Bool, Never> {
        isUserPremiumSubject.eraseToAnyPublisher()
    }

    private let isUserPremiumSubject = CurrentValueSubject<Bool, Never>(false)
    private var updates: Task<Void, Never>?

    init() {
        isUserPremiumSubject.send(UserDefaultsConfig.iapUserIsPremium)
        updates = listenForTransactions()

        Task {
            await getProducts()
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
        guard let result = await Transaction.latest(for: product.id) else { return false }
        do {
            let transaction = try checkVerified(result)
            return transaction.revocationDate == nil && !transaction.isUpgraded
        } catch {
            return false
        }
    }

    func handlePurchasedProduct(with transaction: Transaction) async {
        UserDefaultsConfig.iapProductIdentifiers.append(transaction.productID)
        if transaction.productType == .autoRenewable, let expirationDate = transaction.expirationDate {
            let isUserPremium = expirationDate > Date()
            UserDefaultsConfig.iapUserIsPremium = isUserPremium
            isUserPremiumSubject.send(isUserPremium)
        }
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
                    await self.handlePurchasedProduct(with: transaction)
                    await transaction.finish()
                } catch {
                    // ignore unverified transactions
                }
            }
        }
    }
}
