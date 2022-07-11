//
//  SubscriptionsView.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 09.07.2022.
//

import SwiftUI
import Combine

struct SubscriptionsView: View {
    class ViewData: ObservableObject {
        @Published var products: [IapProduct] = []
    }

    @ObservedObject var viewData: ViewData
    let closeTap = PassthroughSubject<Void, Never>()

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(viewData.products) { product in
                        Text(product.name)
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
                    closeTap.send()
                }
            }
        }
    }
}

struct SubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionsView(viewData: .init())
    }
}
