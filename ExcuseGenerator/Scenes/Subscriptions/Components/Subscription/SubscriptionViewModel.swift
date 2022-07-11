//
//  SubscriptionViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 11.07.2022.
//

import SwiftUI
import Combine
import CoordinatorRouter

class SubscriptionViewModel: ObservableObject, Identifiable {
    @Published var isBuying: Bool = false

    let product: IapProduct
    var id: String { product.id }
    var isProductPurchased: Bool { iapManager.isPurchased(product) }

    private let iapManager: IapManagerType
    private let iapService: IapServiceType
    private let cancelBag: CancelBag = .init()

    init(product: IapProduct, iapManager: IapManagerType, iapService: IapServiceType) {
        self.product = product
        self.iapManager = iapManager
        self.iapService = iapService
        setupBindings()
    }

    func buyProduct() {
        isBuying = true
        iapManager.buyProduct(product)
    }

    private func setupBindings() {
        iapManager.transactionResult
            .filter { [weak self] _ in self?.isBuying == true }
            .handleEvents(receiveOutput: { [weak self] state in
                switch state {
                case .failure:
                    self?.isBuying = false
                default:
                    break
                }
            })
            .filter { $0 == .success }
            .flatMap { [weak self] _ -> AnyPublisher<ReceiptValidation, Never> in
                guard let self = self else { return Empty<ReceiptValidation, Never>().eraseToAnyPublisher() }
                guard let receipt = self.iapManager.getReceipt() else { return Just(ReceiptValidation.invalid).eraseToAnyPublisher() }
                return self.iapService.validateReceipt(receipt: receipt)
            }
            .sink { [weak self] receiptValidation in
                guard let self = self else { return }
                self.iapManager.handlePurchasedProduct(product: self.product, receiptValidation: receiptValidation)
                self.iapManager.cleanTransactions()
                self.isBuying = false
            }
            .store(in: cancelBag)
    }
}

extension SubscriptionViewModel {
    static func == (lhs: SubscriptionViewModel, rhs: SubscriptionViewModel) -> Bool {
        lhs.product.id == rhs.product.id
    }
}
