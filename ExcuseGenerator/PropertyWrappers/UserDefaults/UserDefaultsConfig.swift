//
//  UserDefaultsConfig.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 11.07.2022.
//

import Foundation

// swiftlint:disable explicit_enum_raw_value
enum UserDefaultKey: String {
    case iapProductIdentifiers
    case iapUserIsPremium
}

struct UserDefaultsConfig {
    @UserDefault(UserDefaultKey.iapProductIdentifiers.rawValue, defaultValue: []) static var iapProductIdentifiers: [String]
    @UserDefault(UserDefaultKey.iapUserIsPremium.rawValue, defaultValue: false) static var iapUserIsPremium: Bool

    static func removeAll() {
        UserDefaults.standard.dictionaryRepresentation().keys.forEach { UserDefaults.standard.removeObject(forKey: $0) }
        UserDefaults.standard.synchronize()
    }

    static func removeAll(except keys: UserDefaultKey...) {
        let keyValues = keys.map { $0.rawValue }
        UserDefaults.standard.dictionaryRepresentation().keys.forEach { key in
            if !keyValues.contains(key) {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
        UserDefaults.standard.synchronize()
    }
}
