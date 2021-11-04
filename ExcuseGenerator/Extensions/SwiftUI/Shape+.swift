//
//  Shape+.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 30.10.2021.
//

import SwiftUI

extension Shape {
    func style<StrokeContent: ShapeStyle, FillContent: ShapeStyle>(
        withStroke strokeContent: StrokeContent,
        lineWidth: CGFloat = 1,
        fill fillContent: FillContent
    ) -> some View {
        self.stroke(strokeContent, lineWidth: lineWidth)
            .background(fill(fillContent))
    }
}
