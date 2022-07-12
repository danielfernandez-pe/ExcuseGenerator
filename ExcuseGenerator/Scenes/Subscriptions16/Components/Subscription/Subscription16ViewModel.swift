//
//  Subscription16ViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 12.07.2022.
//

import StoreKit
import SwiftUI
import Combine
import CoordinatorRouter

@available(iOS 16, *)
class Subscription16ViewModel: ObservableObject, Identifiable {
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

    @MainActor
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
                await checkIfProductIsPurchased()
            } catch {
                // handle error with user
            }
        }
    }

    private func setupBindings() {
    }
}

@available(iOS 16, *)
extension Subscription16ViewModel {
    static func == (lhs: Subscription16ViewModel, rhs: Subscription16ViewModel) -> Bool {
        lhs.product.id == rhs.product.id
    }
}
