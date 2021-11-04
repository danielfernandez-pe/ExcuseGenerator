//
//  Test2View.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 24.10.2021.
//

import SwiftUI
import Combine

struct Test2View: View {
    let popTap = PassthroughSubject<Void, Never>()
    let finishTap = PassthroughSubject<Void, Never>()

    var body: some View {
        VStack {
            Button(action: { popTap.send(()) }, label: {
                Text("Pop to the previous")
            })
            Button(action: { finishTap.send(()) }, label: {
                Text("Finish the flow and return to root")
            })
        }
    }
}

struct Test2View_Previews: PreviewProvider {
    static var previews: some View {
        Test2View()
    }
}
