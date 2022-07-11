//
//  StoreProduct.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 11.07.2022.
//

import Foundation

extension IapManager {
    enum StoreProduct {
        case consumable(Consumable)
        case subscription(Subscription)

        init?(id: String) {
            if let consumable = Consumable(rawValue: id) {
                self = .consumable(consumable)
            } else if let subscription = Subscription(rawValue: id) {
                self = .subscription(subscription)
            }

            return nil
        }
    }

    // swiftlint:disable duplicate_enum_cases
    enum Consumable: String {
        #if APPSTORE
        case consumableBoss = ""
        #else
        case consumableBoss = "excusator.consumable.boss"
        #endif
    }

    enum Subscription: String {
        #if APPSTORE
        case subscriptionMonthly = ""
        case subscriptionYearly = ""
        #else
        case subscriptionMonthly = "excusator.subscriptions.monthly"
        case subscriptionYearly = "excusator.subscriptions.yearly"
        #endif
    }

    static var availableProductIds: Set<String> {
        [
            Consumable.consumableBoss.rawValue,
            Subscription.subscriptionMonthly.rawValue,
            Subscription.subscriptionYearly.rawValue
        ]
    }
}
