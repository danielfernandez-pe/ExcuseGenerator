//
//  SubscriptionsViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 09.07.2022.
//

import Foundation
import Combine
import CoordinatorRouter
import StoreKit

// swiftlint:disable action_happened
final class SubscriptionsViewModel: ObservableObject {
    let closeTap = PassthroughSubject<Void, Never>()

    @Published var productViewModels: [SubscriptionViewModel] = []
    private let iapManager: IapManagerType
    private let iapService: IapServiceType

    // MARK: - Initialization

    init(iapManager: IapManagerType, iapService: IapServiceType) {
        self.iapManager = iapManager
        self.iapService = iapService
        setupDataUpdates()
    }

    func setupDataUpdates() {
        iapManager.availableProducts
            .receive(on: DispatchQueue.main)
            .compactMap { [weak self] result -> [SubscriptionViewModel]? in
                guard let self = self else { return nil }
                switch result {
                case .empty, .error:
                    return nil
                case .fetched(let products):
                    return products.map { product -> SubscriptionViewModel in
                        let iapProduct = IapProduct(
                            id: product.productIdentifier,
                            name: product.localizedTitle,
                            price: self.iapManager.getProductPrice(for: product)
                        )
                        return SubscriptionViewModel(product: iapProduct, iapManager: self.iapManager, iapService: self.iapService)
                    }
                }
            }
            .assign(to: &$productViewModels)
    }
}
