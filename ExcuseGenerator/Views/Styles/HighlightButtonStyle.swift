//
//  HighlightButtonStyle.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 29.10.2021.
//

import SwiftUI

struct HighlightButtonStyle: ButtonStyle {
    var backgroundColor: Color
    var backgroundHighlightColor: Color
    private let scale: CGFloat = 0.96

    init(backgroundColor: Color, backgroundHighlightColor: Color) {
        self.backgroundColor = backgroundColor
        self.backgroundHighlightColor = backgroundHighlightColor
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scale : 1)
            .background(configuration.isPressed ? backgroundHighlightColor : backgroundColor)
            .animation(.easeInOut(duration: 0.3))
    }
}
