//
//  AppDependency.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 23.10.2021.
//

import Foundation

typealias AllDependencies = HasDummyManager & HasExcuseService

protocol HasDummyManager {}

protocol HasExcuseService {
    var excuseService: ExcuseServiceType { get }
}

struct AppDependency: AllDependencies {
    let excuseService: ExcuseServiceType

    init() {
        excuseService = ExcuseService()
    }
}
