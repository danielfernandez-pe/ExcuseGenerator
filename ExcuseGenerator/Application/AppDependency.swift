//
//  AppDependency.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 23.10.2021.
//

import Foundation

struct AppDependencySk2 {
    @available(iOS 15, *)
    static let iapManagerSk2: IapManagerTypeSk2 = IapManagerStoreKit2()
}

typealias AllDependencies = HasDummyManager &
                            HasExcuseService &
                            HasIapManager &
                            HasIapManagerUserPremium

protocol HasDummyManager {}

protocol HasExcuseService {
    var excuseService: ExcuseServiceType { get }
}

protocol HasIapManager {
    var iapManager: IapManagerType { get }
}

protocol HasIapManagerUserPremium {
    var iapManagerUserPremium: IapManagerUserPremium { get }
}

struct AppDependency: AllDependencies {
    let excuseService: ExcuseServiceType
    let iapManager: IapManagerType
    let iapManagerUserPremium: IapManagerUserPremium

    init() {
        excuseService = ExcuseService()
        iapManager = IapManager()

        if #available(iOS 15, *) {
            iapManagerUserPremium = AppDependencySk2.iapManagerSk2
        } else {
            iapManagerUserPremium = iapManager
        }
    }
}
