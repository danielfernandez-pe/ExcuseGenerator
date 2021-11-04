//
//  ScaleButtonStyle.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 26.10.2021.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    private let scale: CGFloat = 0.96

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1)
            .animation(.easeInOut(duration: 0.3))
    }
}
