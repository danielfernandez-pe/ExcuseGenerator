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
                    ForEach(viewModel.productViewModels) { viewModel in
                        SubscriptionView(viewModel: viewModel)
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

struct SubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionsView(
            viewModel: .init(iapManager: IapManager(), iapService: IapService())
        )
    }
}

extension View {
    func debugRedraw() -> some View {
        background(Color.debug)
    }
}

extension ShapeStyle where Self == Color {
    static var debug: Color {
        #if DEVEL
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        ).opacity(0.7)
        #else
        Color.clear
        #endif
    }
}
