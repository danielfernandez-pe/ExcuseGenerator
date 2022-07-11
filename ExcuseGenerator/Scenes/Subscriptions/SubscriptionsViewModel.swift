//
//  SubscriptionsViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 09.07.2022.
//

import Combine
import CoordinatorRouter

// swiftlint:disable action_happened
final class SubscriptionsViewModel: ObservableObject {
    let closeTap = PassthroughSubject<Void, Never>()

    @Published var products: [IapProduct] = []

    private let iapManager: IapManagerType

    // MARK: - Initialization

    init(iapManager: IapManagerType) {
        self.iapManager = iapManager
        setupDataUpdates()
    }

    func setupDataUpdates() {
        iapManager.availableProducts
            .compactMap { [weak self] result -> [IapProduct]? in
                guard let self = self else { return nil }
                switch result {
                case .empty, .error:
                    return nil
                case .fetched(let products):
                    return products.map { product -> IapProduct in
                        IapProduct(
                            id: product.productIdentifier,
                            name: product.localizedTitle,
                            price: self.iapManager.getProductPrice(for: product)
                        )
                    }
                }
            }
            .assign(to: &$products)
    }
}
