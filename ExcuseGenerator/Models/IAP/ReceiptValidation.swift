//
//  ReceiptValidation.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 11.07.2022.
//

import Foundation

struct ReceiptValidation: Codable {
    var expirationAt: Date
    var receiptValid: Bool
    var receiptExpired: Bool

    static var invalid: ReceiptValidation {
        ReceiptValidation(
            expirationAt: Date(),
            receiptValid: false,
            receiptExpired: true
        )
    }
}
