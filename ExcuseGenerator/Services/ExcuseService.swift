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
    let excuseRange = 0...24
    lazy var introExcuses = excuseRange.map { NSLocalizedString("intro.excuse\($0)", comment: "") }
    lazy var scapegoatExcuses = excuseRange.map { NSLocalizedString("scapegoat.excuse\($0)", comment: "") }
    lazy var endingExcuses = excuseRange.map { NSLocalizedString("ending.excuse\($0)", comment: "") }

    func getRandomExcuse() -> String {
        let range = 0..<introExcuses.count
        let introIndex = Int.random(in: range)
        let scapegoatIndex = Int.random(in: range)
        let endingIndex = Int.random(in: range)

        let excuse = "\(introExcuses[introIndex]) \(scapegoatExcuses[scapegoatIndex]) \(endingExcuses[endingIndex])"
        introExcuses.remove(at: introIndex)
        scapegoatExcuses.remove(at: scapegoatIndex)
        endingExcuses.remove(at: endingIndex)

        resetExcusesIfNeeded()
        return excuse
    }

    func excuses(for type: ExcuseType) -> [String] {
        switch type {
        case .intro:
            return excuseRange.map { NSLocalizedString("intro.excuse\($0)", comment: "") }
        case .scapegoat:
            return excuseRange.map { NSLocalizedString("scapegoat.excuse\($0)", comment: "") }
        case .ending:
            return excuseRange.map { NSLocalizedString("ending.excuse\($0)", comment: "") }
        }
    }

    private func resetExcusesIfNeeded() {
        guard introExcuses.isEmpty else { return }
        introExcuses = excuseRange.map { NSLocalizedString("intro.excuse\($0)", comment: "") }
        scapegoatExcuses = excuseRange.map { NSLocalizedString("scapegoat.excuse\($0)", comment: "") }
        endingExcuses = excuseRange.map { NSLocalizedString("ending.excuse\($0)", comment: "") }
    }
}
