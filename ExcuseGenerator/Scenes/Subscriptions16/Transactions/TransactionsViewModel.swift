//
//  TransactionsViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 13.07.2022.
//

import Foundation
import Combine
import CoordinatorRouter
import StoreKit

// swiftlint:disable action_happened
@available(iOS 16, *)
final class TransactionsViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []

    private let iapManager: IapManagerTypeSk2

    // MARK: - Initialization

    init(iapManager: IapManagerTypeSk2) {
        self.iapManager = iapManager
    }

    @MainActor
    func getTransactions() async {
        transactions = await iapManager.getLatestTransactions()
    }
}
