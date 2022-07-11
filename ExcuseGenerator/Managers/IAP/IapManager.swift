//
//  IapManager.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 09.07.2022.
//

import Foundation
import StoreKit
import Combine

enum IAPPurchaseFetchResult {
    case empty
    case fetched(products: [SKProduct])
    case error(error: Error)
}

enum IAPTransactionResult {
    case inProcess
    case success
    case failure
}

enum IAPPurchaseError: Error {
    case generic
}

protocol IapManagerType {
    var canMakePayments: Bool { get }
    var availableProducts: AnyPublisher<IAPPurchaseFetchResult, Never> { get }
    var transactionResult: AnyPublisher<IAPTransactionResult, Never> { get }

    func getProducts()
    func purchaseProduct(_ product: IapManager.StoreProduct)
    func restorePurchases()
    func getReceipt() -> String?
    func cleanTransactions()
    func getProductPrice(for product: IapManager.StoreProduct) -> String
}

final class IapManager: NSObject, IapManagerType {
    var canMakePayments: Bool {
        SKPaymentQueue.canMakePayments()
    }

    var transactionResult: AnyPublisher<IAPTransactionResult, Never> {
        transactionHandler.eraseToAnyPublisher()
    }

    var availableProducts: AnyPublisher<IAPPurchaseFetchResult, Never> {
        fetchedProducts.eraseToAnyPublisher()
    }

    private let fetchedProducts = CurrentValueSubject<IAPPurchaseFetchResult, Never>(.empty)
    private let transactionHandler = PassthroughSubject<IAPTransactionResult, Never>()
    private var productsRequest: SKProductsRequest?
    private var refreshReceiptRequest: SKReceiptRefreshRequest?
    private var currentPurchasedTransaction: SKPaymentTransaction?

    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
        getProducts()
    }

    deinit {
        SKPaymentQueue.default().remove(self)
    }

    func getProducts() {
        productsRequest?.cancel()
        productsRequest = SKProductsRequest(productIdentifiers: StoreProduct.availableProductIds)
        productsRequest?.delegate = self
        productsRequest?.start()
    }

    func purchaseProduct(_ product: IapManager.StoreProduct) {
        let id = product.rawValue
        print("Starting purchase for IAP product with id: \(id)")
        guard case .fetched(let products) = fetchedProducts.value,
              let product = products.first(where: { $0.productIdentifier == id }) else { return }

        removeUnfinishedTransactionsIfNeeded {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
        }
    }

    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    func getReceipt() -> String? {
        if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
            FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {
            do {
                let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
                let receiptString = receiptData.base64EncodedString(options: [])
                return receiptString
            } catch {
                return nil
            }
        } else {
            refreshReceipt()
        }

        return nil
    }

    func getProductPrice(for product: IapManager.StoreProduct) -> String {
        switch fetchedProducts.value {
        case .empty, .error:
            return ""
        case .fetched(let products):
            guard let product = products.first(where: { $0.productIdentifier == product.rawValue }) else { return "" }
            let formatter = NumberFormatter()
            return formatter.subscriptionPrice(price: product.price, priceLocale: product.priceLocale) ?? ""
        }
    }

    private func refreshReceipt() {
        guard refreshReceiptRequest == nil else { return }
        refreshReceiptRequest = SKReceiptRefreshRequest()
        refreshReceiptRequest?.delegate = self
        refreshReceiptRequest?.start()
    }

    func cleanTransactions() {
        guard let transaction = currentPurchasedTransaction else { return }
        SKPaymentQueue.default().finishTransaction(transaction)
        currentPurchasedTransaction = nil
    }

    // Apple sandbox bug. I had to finish unfinished transaction before doing a new purchase. This is
    // to avoid apple always sending back an old expiration date when buying again.
    private func removeUnfinishedTransactionsIfNeeded(completion: () -> Void) {
        defer { completion() }
        let sandbox = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
        guard sandbox else { return }

        for transaction in SKPaymentQueue.default().transactions {
            if transaction.transactionDate == nil || transaction.transactionDate!.timeIntervalSinceNow < -300 {
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
}

extension IapManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("\(response.products.count) IAP products fetched")
        fetchedProducts.send(.fetched(products: response.products))
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Error while requesting IAP products \(error.localizedDescription)")
        fetchedProducts.send(.error(error: error))
    }

    func requestDidFinish(_ request: SKRequest) {
        if request is SKReceiptRefreshRequest {
            refreshReceiptRequest = nil
        }
    }
}

extension IapManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .failed:
                print("IAP transaction failed with error \(transaction.error?.localizedDescription ?? "")")
                transactionHandler.send(.failure)
                SKPaymentQueue.default().finishTransaction(transaction)
            case .purchasing:
                transactionHandler.send(.inProcess)
            case .purchased:
                print("IAP transaction purchased")
                transactionHandler.send(.success)
                currentPurchasedTransaction = transaction
            case .deferred:
                print("IAP transaction deferred")
            case .restored:
                print("IAP transaction restored")
                transactionHandler.send(.success)
                currentPurchasedTransaction = transaction
            @unknown default:
                assertionFailure("Handle new IAP status")
            }
        }
    }

    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("IAP transaction failed with error \(error.localizedDescription)")
        transactionHandler.send(.failure)
    }

    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        false
    }
}
