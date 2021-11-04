//
//  ViewModelType.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 23.10.2021.
//

import UIKit

struct ViewModelWrapper<VM: ViewModelType> {
    let dependencies: VM.Dependency

    init(_ dependencies: VM.Dependency) {
        self.dependencies = dependencies
    }

    func bind(_ bindings: VM.Bindings) -> VM {
        VM(dependency: dependencies, bindings: bindings)
    }
}

protocol ViewModelType {
    associatedtype Dependency
    associatedtype Bindings

    init(dependency: Dependency, bindings: Bindings)
}
