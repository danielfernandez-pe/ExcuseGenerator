//
//  NoneButtonStyle.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 30.10.2021.
//

import SwiftUI

struct NoneButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}
