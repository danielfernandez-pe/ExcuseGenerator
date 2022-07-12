//
//  SubscriptionSk2ViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 12.07.2022.
//

import StoreKit
import SwiftUI
import Combine
import CoordinatorRouter

@available(iOS 15, *)
class SubscriptionSk2ViewModel: ObservableObject, Identifiable {
    @Published var isBuying: Bool = false
    @Published var isPurchased: Bool = false

    let product: Product
    var id: String { product.id }

    private let iapManager: IapManagerTypeSk2
    private let cancelBag: CancelBag = .init()

    init(product: Product, iapManager: IapManagerTypeSk2) {
        self.product = product
        self.iapManager = iapManager
        setupBindings()
    }

    func checkIfProductIsPurchased() async {
        isPurchased = await iapManager.isPurchased(product)
    }

    @MainActor
    func buyProduct() {
        isBuying = true
        Task {
            do {
                try await iapManager.buyProduct(product)
                isBuying = false
            } catch {
                // handle error with user
            }
        }
    }

    private func setupBindings() {
    }
}

@available(iOS 15, *)
extension SubscriptionSk2ViewModel {
    static func == (lhs: SubscriptionSk2ViewModel, rhs: SubscriptionSk2ViewModel) -> Bool {
        lhs.product.id == rhs.product.id
    }
}
