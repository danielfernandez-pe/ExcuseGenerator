//
//  HighlightedButton.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 29.10.2021.
//

import SwiftUI

struct HighlightedButton: View {
    let text: String
    let textColor: Color
    let textHighlightedColor: Color
    let backgroundColor: Color
    let backgroundHighlightedColor: Color
    let action: () -> Void

    @State private var isPressed = false
    private let scale: CGFloat = 0.96

    var body: some View {
        Button(action: action, label: {
            Text(text)
                .textStyle(.text2)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(isPressed ? textHighlightedColor : textColor)
                .background(
                    RoundedRectangle(cornerRadius: Appearance.UIProperties.bigCornerRadius)
                        .style(
                            withStroke: isPressed ? .clear : Color(R.color.buttonBorder.name),
                            lineWidth: isPressed ? 0 : 2,
                            fill: isPressed ? backgroundHighlightedColor : backgroundColor
                        )
                        .shadow(color: Color(R.color.shadow.name), radius: 15)
                )
        })
        .frame(height: 56)
        .scaleEffect(isPressed ? scale : 1)
        .buttonStyle(NoneButtonStyle())
        .onLongPressGesture(
            minimumDuration: 0,
            maximumDistance: .infinity,
            perform: {},
            onPressingChanged: { isPressed in
                self.isPressed = isPressed
            }
        )
    }
}
