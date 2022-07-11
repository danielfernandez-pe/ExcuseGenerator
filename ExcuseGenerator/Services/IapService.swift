//
//  IapService.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 11.07.2022.
//

import Foundation
import Combine

protocol IapServiceType {
    func validateReceipt(receipt: String) -> AnyPublisher<ReceiptValidation, Never>
}

final class IapService: IapServiceType {
    func validateReceipt(receipt: String) -> AnyPublisher<ReceiptValidation, Never> {
        Just(
            ReceiptValidation(
                expirationAt: Date(),
                receiptValid: true,
                receiptExpired: false
            )
        )
        .delay(for: 2, scheduler: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
