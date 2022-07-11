//
//  SubscriptionsView.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 09.07.2022.
//

import SwiftUI
import Combine

struct SubscriptionsView: View {
    @ObservedObject var viewModel: SubscriptionsViewModel

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.products) { product in
                        SubscriptionView(product: product, isBuying: true) {
                            print("buy!")
                        }
                    }
                }
                .padding()
            }
        }
        .background(
            Color(R.color.white.name)
                .ignoresSafeArea()
        )
        .navigationTitle("Subscriptions")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Close") {
                    viewModel.closeTap.send()
                }
            }
        }
    }
}

struct SubscriptionView: View {
    let product: IapProduct
    let isBuying: Bool
    let buyAction: () -> Void

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(product.name)

                    Text(product.price)
                }

                Spacer()

                if isBuying {
                    ProgressView()
                } else {
                    Button("Buy", action: buyAction)
                }
            }

            Divider()
        }
    }
}

struct SubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionsView(viewModel: .init(iapManager: IapManager()))
    }
}
