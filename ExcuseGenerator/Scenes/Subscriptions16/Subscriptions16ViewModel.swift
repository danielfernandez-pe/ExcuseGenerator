//
//  Subscriptions16ViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 12.07.2022.
//

import Foundation
import Combine
import StoreKit

// swiftlint:disable action_happened
@available(iOS 16, *)
final class Subscriptions16ViewModel: ObservableObject {
    let closeTap = PassthroughSubject<Void, Never>()
    let showTransactions = PassthroughSubject<Void, Never>()

    @Published var productViewModels: [Subscription16ViewModel] = []
    private let iapManager: IapManagerTypeSk2

    // MARK: - Initialization

    init(iapManager: IapManagerTypeSk2) {
        self.iapManager = iapManager
    }

    @MainActor
    func getProducts() async {
        productViewModels.removeAll() // TODO: Handle in a better way to not redraw everything
        let products = await iapManager.getProducts()
        for product in products {
            let viewModel = Subscription16ViewModel(product: product, iapManager: iapManager)
            productViewModels.append(viewModel)
        }
    }
}
