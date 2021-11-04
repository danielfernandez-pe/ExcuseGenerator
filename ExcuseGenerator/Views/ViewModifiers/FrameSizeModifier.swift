//
//  FrameSizeModifier.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 26.10.2021.
//

import SwiftUI

struct FrameSizeModifier: ViewModifier {
    let size: CGSize
    var alignment: Alignment

    func body(content: Content) -> some View {
        content
            .frame(width: size.width, height: size.height, alignment: alignment)
    }
}

extension View {
    func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        modifier(FrameSizeModifier(size: size, alignment: alignment))
    }
}
