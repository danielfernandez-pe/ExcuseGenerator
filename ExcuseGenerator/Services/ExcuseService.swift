//
//  ExcuseService.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 30.10.2021.
//

import Foundation
import SwiftUI

enum ExcuseType {
    case intro, scapegoat, ending
}

protocol ExcuseServiceType {
    func getRandomExcuse() -> String
    func excuses(for type: ExcuseType) -> [String]
}

final class ExcuseService: ExcuseServiceType {
    enum ExcuseRange {
        static let intro: ClosedRange = 1...9
        static let scapegoat: ClosedRange = 1...25
        static let ending: ClosedRange = 1...13
    }

    func getRandomExcuse() -> String {
        let introIndex = Int.random(in: ExcuseRange.intro)
        let scapegoatIndex = Int.random(in: ExcuseRange.scapegoat)
        let endingIndex = Int.random(in: ExcuseRange.ending)
        let intro = NSLocalizedString("intro.excuse\(introIndex)", comment: "")
        let scapegoat = NSLocalizedString("scapegoat.excuse\(scapegoatIndex)", comment: "")
        let ending = NSLocalizedString("ending.excuse\(endingIndex)", comment: "")
        return "\(intro) \(scapegoat) \(ending)"
    }

    func excuses(for type: ExcuseType) -> [String] {
        switch type {
        case .intro:
            return ExcuseRange.intro.map { NSLocalizedString("intro.excuse\($0)", comment: "") }
        case .scapegoat:
            return ExcuseRange.scapegoat.map { NSLocalizedString("scapegoat.excuse\($0)", comment: "") }
        case .ending:
            return ExcuseRange.ending.map { NSLocalizedString("ending.excuse\($0)", comment: "") }
        }
    }
}
