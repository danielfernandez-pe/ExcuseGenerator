//
//  SubscriptionView.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 11.07.2022.
//

import SwiftUI

struct SubscriptionView: View {
    @ObservedObject var viewModel: SubscriptionViewModel

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.product.name)

                    Text(viewModel.product.price)
                }

                Spacer()

                if viewModel.isBuying {
                    ProgressView()
                } else {
                    if viewModel.isProductPurchased {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    } else {
                        Button("Buy", action: viewModel.buyProduct)
                    }
                }
            }

            Divider()
        }
        .debugRedraw()
    }
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView(
            viewModel: .init(
                product: IapProduct(
                    id: "1",
                    name: "Test",
                    price: "4.99 EUR"
                ),
                iapManager: IapManager(),
                iapService: IapService()
            )
        )
    }
}
