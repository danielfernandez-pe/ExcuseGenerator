//
//  Subscription16View.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 12.07.2022.
//

import SwiftUI

@available(iOS 16, *)
struct Subscription16View: View {
    @ObservedObject var viewModel: Subscription16ViewModel

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.product.displayName)

                    Text(viewModel.product.displayPrice)
                }

                Spacer()

                if viewModel.isBuying {
                    ProgressView()
                } else {
                    if viewModel.isPurchased {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    } else {
                        Button("Buy", action: { viewModel.buyProduct() })
                    }
                }
            }

            Divider()
        }
        .debugRedraw()
        .task {
            await viewModel.checkIfProductIsPurchased()
        }
    }
}
