//
//  ColoredText.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 26.10.2021.
//

import SwiftUI

struct ColoredText: View {
    let text: String
    let matching: String
    let color: Color

    init(_ text: String, matching: String, color: Color) {
        self.text = text
        self.matching = matching
        self.color = color
    }

    var body: some View {
        let tagged = text.replacingOccurrences(of: self.matching, with: "<SPLIT>>\(self.matching)<SPLIT>")
        let split = tagged.components(separatedBy: "<SPLIT>")
        return split.reduce(Text("")) { full, splitted -> Text in
            guard !splitted.hasPrefix(">") else {
                return full + Text(splitted.dropFirst()).foregroundColor(color)
            }
            return full + Text(splitted)
        }
    }
}
