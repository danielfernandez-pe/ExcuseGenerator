//
//  SubscriptionsSk2ViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 12.07.2022.
//

import Foundation
import Combine
import CoordinatorRouter
import StoreKit

// swiftlint:disable action_happened
@available(iOS 15, *)
final class SubscriptionsSk2ViewModel: ObservableObject {
    let closeTap = PassthroughSubject<Void, Never>()

    @Published var productViewModels: [SubscriptionSk2ViewModel] = []
    private let iapManager: IapManagerTypeSk2

    // MARK: - Initialization

    init(iapManager: IapManagerTypeSk2) {
        self.iapManager = iapManager
    }

    @MainActor
    func getProducts() async {
        let products = await iapManager.getProducts()
        for product in products {
            let viewModel = SubscriptionSk2ViewModel(product: product, iapManager: iapManager)
            productViewModels.append(viewModel)
        }
    }

    func redeemCode() {
        SKPaymentQueue.default().presentCodeRedemptionSheet()
    }
}
