//
//  SubscriptionsSk2View.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 12.07.2022.
//

import SwiftUI
import Combine

@available(iOS 15, *)
struct SubscriptionsSk2View: View {
    @ObservedObject var viewModel: SubscriptionsSk2ViewModel

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.productViewModels) { viewModel in
                        SubscriptionSk2View(viewModel: viewModel)
                    }
                }
                .padding()
            }
        }
        .background(
            Color(R.color.white.name)
                .ignoresSafeArea()
        )
        .navigationTitle("Subscriptions Storekit 2")
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
    }
}

@available(iOS 15, *)
struct SubscriptionsSk2View_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionsSk2View(
            viewModel: .init(iapManager: IapManagerStoreKit2())
        )
    }
}
