//
//  NumberFormatter+.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 11.07.2022.
//

import Foundation

extension NumberFormatter {
    func subscriptionPrice(price: NSNumber, priceLocale: Locale) -> String? {
        self.numberStyle = .currency
        self.locale = priceLocale
        return string(from: price)
    }
}
