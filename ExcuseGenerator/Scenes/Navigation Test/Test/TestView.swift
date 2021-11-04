//
//  TestView.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 24.10.2021.
//

import SwiftUI
import Combine

struct TestView: View {
    let pushTap = PassthroughSubject<Void, Never>()

    var body: some View {
        Button(action: { pushTap.send(()) }, label: {
            Text("Push to the next")
        })
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
