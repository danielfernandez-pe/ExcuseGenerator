//
//  Subscriptions16ViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 12.07.2022.
//

import Foundation
import Combine
import CoordinatorRouter
import StoreKit

// swiftlint:disable action_happened
@available(iOS 16, *)
final class Subscriptions16ViewModel: ObservableObject {
    let closeTap = PassthroughSubject<Void, Never>()

    @Published var productViewModels: [Subscription16ViewModel] = []
    private let iapManager: IapManagerTypeSk2

    // MARK: - Initialization

    init(iapManager: IapManagerTypeSk2) {
        self.iapManager = iapManager
    }

    @MainActor
    func getProducts() async {
        let products = await iapManager.getProducts()
        for product in products {
            let viewModel = Subscription16ViewModel(product: product, iapManager: iapManager)
            productViewModels.append(viewModel)
        }
    }

    private func listenForMessages() async throws {
        for await message in Message.messages {
        }

        for await status in Product.SubscriptionInfo.Status.updates {
            let renewalInfo = try status.renewalInfo.payloadValue

            if renewalInfo.priceIncreaseStatus == .agreed {
            }

            if renewalInfo.expirationReason == .didNotConsentToPriceIncrease {
            }

            if let gracePeriodExpirationDate = renewalInfo.gracePeriodExpirationDate, gracePeriodExpirationDate < .now {
                print("In grace period until \(gracePeriodExpirationDate)")
            } else if renewalInfo.isInBillingRetry {
                
            }
        }
    }
}
