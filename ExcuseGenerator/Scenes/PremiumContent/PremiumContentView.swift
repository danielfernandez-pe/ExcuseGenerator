//
//  PremiumContentView.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 11.07.2022.
//

import SwiftUI
import Combine

struct PremiumContentView: View {
    @ObservedObject var viewModel: PremiumContentViewModel

    var body: some View {
        VStack {
            Text("Premium user!")
            Image(systemName: "applelogo")
                .resizable()
                .scaledToFit()
                .frame(size: .init(width: 100, height: 100))
                .foregroundColor(.green)
        }
        .background(
            Color(R.color.white.name)
                .ignoresSafeArea()
        )
        .navigationBarHidden(false)
        .navigationTitle("Top secret content")
    }
}

struct PremiumContentView_Previews: PreviewProvider {
    static var previews: some View {
        PremiumContentView(viewModel: .init())
    }
}
