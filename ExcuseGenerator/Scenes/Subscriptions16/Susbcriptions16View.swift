//
//  Susbcriptions16View.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 12.07.2022.
//

import SwiftUI
import Combine

@available(iOS 16, *)
struct Susbcriptions16View: View {
    @ObservedObject var viewModel: Subscriptions16ViewModel
    @State private var redeemSheetIsPresented = false
    @Environment(\.requestReview) private var requestReview

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.productViewModels) { cellViewModel in
                        Subscription16View(
                            viewModel: cellViewModel
                        )
                    }

                    Button("Redeem code") {
                        redeemSheetIsPresented = true
                    }

                    Button("Refund transactions") {
                        viewModel.showTransactions.send()
                    }
                }
                .padding()
            }
        }
        .background(
            Color(R.color.white.name)
                .ignoresSafeArea()
        )
        .navigationTitle("Subscriptions iOS 16")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Close") {
                    viewModel.closeTap.send()
                }
            }
        }
        .task {
            await viewModel.getProducts()
        }
        .offerCodeRedemption(isPresented: $redeemSheetIsPresented) { result in
            switch result {
            case .failure(let error):
                print("Handle error \(error.localizedDescription)")
            default:
                Task {
                    await viewModel.getProducts()
                }
            }
        }
        .onAppear {
            if self.shouldRequestReview() {
                requestReview()
            }
        }
    }

    private func shouldRequestReview() -> Bool {
        false
    }
}

@available(iOS 16, *)
struct Susbcriptions16View_Previews: PreviewProvider {
    static var previews: some View {
        Susbcriptions16View(
            viewModel: .init(iapManager: IapManagerStoreKit2())
        )
    }
}
