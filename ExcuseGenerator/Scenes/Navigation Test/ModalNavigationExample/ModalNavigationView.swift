//
//  ModalNavigationView.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 24.10.2021.
//

import SwiftUI
import Combine

struct ModalNavigationView: View {
    let pushTap = PassthroughSubject<Void, Never>()

    var body: some View {
        Button(action: { pushTap.send(()) }, label: {
            Text("Modal Navigation Example, continue with a push")
        })
    }
}

struct ModalNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        ModalNavigationView()
    }
}
