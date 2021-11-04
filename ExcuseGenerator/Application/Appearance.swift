//
//  Appearance.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 24.10.2021.
//

import UIKit
import SwiftUI

struct Appearance {
    // MARK: - UIProperties

    enum UIProperties {
        /// 4
        static let smallCornerRadius: CGFloat = 4
        /// 8
        static let normalCornerRadius: CGFloat = 8
        /// 16
        static let bigCornerRadius: CGFloat = 16
    }

    static private let barButtonAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
        NSAttributedString.Key.foregroundColor: R.color.grey() ?? .black
    ]

    static private var regularBarAppearance: UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.buttonAppearance.normal.titleTextAttributes = barButtonAttributes
        appearance.doneButtonAppearance.normal.titleTextAttributes = barButtonAttributes
        appearance.setBackIndicatorImage(R.image.icBack(), transitionMaskImage: R.image.icBack())
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: R.color.black() ?? .black
        ]

        appearance.largeTitleTextAttributes = [
            .foregroundColor: R.color.black() ?? .black,
            .font: UIFont.boldSystemFont(ofSize: 24)
        ]
        return appearance
    }

    static private func setDefaultNavBarStyle() {
        UINavigationBar.appearance().tintColor = R.color.black()
        UINavigationBar.appearance().standardAppearance = regularBarAppearance
        UINavigationBar.appearance().compactAppearance = regularBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = regularBarAppearance
        UINavigationBar.appearance().prefersLargeTitles = true
    }

    static func setGlobalStyle() {
        setDefaultNavBarStyle()
    }
}

// MARK: - Fonts

extension Appearance {
    enum TextStyle {
        case title1
        case title2
        case headline
        case text1
        case text2

        var font: UIFont {
            switch self {
            case .title1:
                return Font.title1
            case .title2:
                return Font.title2
            case .headline:
                return Font.headline
            case .text1:
                return Font.text1
            case .text2:
                return Font.text2
            }
        }
    }

    struct Font {
        static let title1: UIFont = UIFont.systemFont(ofSize: 50, weight: .bold)
        static let title2: UIFont = UIFont.systemFont(ofSize: 28, weight: .bold)
        static let headline: UIFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
        static let text1: UIFont = UIFont.systemFont(ofSize: 28, weight: .regular)
        static let text2: UIFont = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
}

// MARK: - Paddings

extension Appearance {
    struct Padding {
        /// 8
        static let small: CGFloat = 8
        /// 16
        static let normal: CGFloat = 16
        /// 24
        static let medium: CGFloat = 24
    }
}
