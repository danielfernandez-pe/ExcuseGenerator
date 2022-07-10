//
//  SubscriptionsView.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 09.07.2022.
//

import SwiftUI
import Combine

struct SubscriptionsView: View {
    let giveExcuseTap = PassthroughSubject<Void, Never>()
    let createOwnExcuseTap = PassthroughSubject<Void, Never>()

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("Subscription product")
                }
                .padding()
            }
        }
        .background(
            Color(R.color.white.name)
                .ignoresSafeArea()
        )
        .navigationTitle("Subscriptions")
    }
}

struct SubscriptionsView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionsView()
    }
}
