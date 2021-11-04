//
//  Font+.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 26.10.2021.
//

import UIKit
import SwiftUI

extension UIFont {
    func toFont() -> Font {
        Font(self)
    }
}

private struct TextStyle: ViewModifier {
    let textStyle: Appearance.TextStyle

    func body(content: Content) -> some View {
        content
            .font(textStyle.font.toFont())
    }
}

extension View {
    func textStyle(_ textStyle: Appearance.TextStyle) -> some View {
        modifier(TextStyle(textStyle: textStyle))
    }
}

extension UILabel {
    func textStyle(_ textStyle: Appearance.TextStyle) {
        font = textStyle.font
    }
}
