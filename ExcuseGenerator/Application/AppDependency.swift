//
//  AppDependency.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 23.10.2021.
//

import Foundation

typealias AllDependencies = HasDummyManager &
                            HasExcuseService &
HasIapManager

protocol HasDummyManager {}

protocol HasExcuseService {
    var excuseService: ExcuseServiceType { get }
}

protocol HasIapManager {
    var iapManager: IapManagerType { get }
}

struct AppDependency: AllDependencies {
    let excuseService: ExcuseServiceType
    let iapManager: IapManagerType

    init() {
        excuseService = ExcuseService()
        iapManager = IapManager()
    }
}
