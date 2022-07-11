//
//  StoreProduct.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 11.07.2022.
//

import Foundation

extension IapManager {
    // swiftlint:disable duplicate_enum_cases
    enum StoreProduct: String {
        #if APPSTORE
        case consumableBoss = ""
        case subscriptionMonthly = ""
        case subscriptionYearly = ""
        #else
        case consumableBoss = "excusator.consumable.boss"
        case subscriptionMonthly = "excusator.subscriptions.monthly"
        case subscriptionYearly = "excusator.subscriptions.yearly"
        #endif

        static var availableProductIds: Set<String> {
            [
                StoreProduct.consumableBoss.rawValue,
                StoreProduct.subscriptionMonthly.rawValue,
                StoreProduct.subscriptionYearly.rawValue
            ]
        }
    }
}
