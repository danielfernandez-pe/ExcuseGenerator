//
//  IapService.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 11.07.2022.
//

import Foundation
import Combine

protocol PurchaseServiceType {
    func validateReceipt(receipt: String) -> AnyPublisher<ReceiptValidation, Never>
}

final class PurchaseService: PurchaseServiceType {
    func validateReceipt(receipt: String) -> AnyPublisher<ReceiptValidation, Never> {
        Just(
            ReceiptValidation(
                expirationAt: Date(),
                receiptValid: true,
                receiptExpired: false
            )
        )
        .eraseToAnyPublisher()
    }
}
