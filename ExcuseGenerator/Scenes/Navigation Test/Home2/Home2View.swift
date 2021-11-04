//
//  HomeView.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 23.10.2021.
//

import SwiftUI
import Combine

struct Home2View: View {
    let modalNavigationTap = PassthroughSubject<Void, Never>()
    let modalTap = PassthroughSubject<Void, Never>()
    let navigationTap = PassthroughSubject<Void, Never>()

    var body: some View {
        VStack(spacing: 16) {
            Button(action: { modalNavigationTap.send(()) }, label: {
                Text("Modal Navigation Example")
            })
            Button(action: { modalTap.send(()) }, label: {
                Text("Modal Example")
            })
            Button(action: { navigationTap.send(()) }, label: {
                Text("Navigation push Example")
            })
        }
    }
}

struct Home2View_Previews: PreviewProvider {
    static var previews: some View {
        Home2View()
    }
}
