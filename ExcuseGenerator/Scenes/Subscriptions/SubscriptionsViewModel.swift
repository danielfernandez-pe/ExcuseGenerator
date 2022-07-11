//
//  SubscriptionsViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 09.07.2022.
//

import Combine

// swiftlint:disable action_happened
final class SubscriptionsViewModel: ViewModelType {
    // MARK: - ViewModelType

    typealias Dependency = HasIapManager

    struct Bindings {
        let closeTap: AnyPublisher<Void, Never>
    }

    private(set) var fetchedProducts: AnyPublisher<[IapProduct], Never>!

    // MARK: - Coordinator Bindings

    var closeTapped: AnyPublisher<Void, Never>!

    // MARK: - Initialization

    init(dependency: Dependency, bindings: Bindings) {
        setupActions(dependency: dependency, bindings: bindings)
        setupDataUpdates(dependency: dependency, bindings: bindings)
    }

    func setupActions(dependency: Dependency, bindings: Bindings) {
        closeTapped = bindings.closeTap
    }

    func setupDataUpdates(dependency: Dependency, bindings: Bindings) {
        fetchedProducts = dependency.iapManager.availableProducts
            .compactMap { result -> [IapProduct]? in
                switch result {
                case .empty, .error:
                    return nil
                case .fetched(let products):
                    return products.map { product -> IapProduct in
                        IapProduct(
                            id: product.productIdentifier,
                            name: product.localizedTitle,
                            price: Double(truncating: product.price)
                        )
                    }
                }
            }
            .eraseToAnyPublisher()
    }
}
