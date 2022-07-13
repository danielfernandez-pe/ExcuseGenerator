//
//  TransactionsView.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 13.07.2022.
//

import SwiftUI
import Combine
import StoreKit

@available(iOS 16, *)
struct TransactionsView: View {
    @ObservedObject var viewModel: TransactionsViewModel
    @State private var showRefund = false
    @State private var transactionIdToRefund: UInt64?

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.transactions) { transaction in
                        Text(transaction.productID)
                        Button("Refund") {
                            transactionIdToRefund = transaction.id
                            showRefund = true
                        }
                    }
                }
                .padding()
            }
        }
        .refundRequestSheet(for: transactionIdToRefund ?? 0, isPresented: $showRefund)
        .background(
            Color(R.color.white.name)
                .ignoresSafeArea()
        )
        .navigationTitle("Transactions")
        .task {
            await viewModel.getTransactions()
        }
    }
}

@available(iOS 16, *)
struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView(
            viewModel: .init(iapManager: IapManagerStoreKit2())
        )
    }
}
