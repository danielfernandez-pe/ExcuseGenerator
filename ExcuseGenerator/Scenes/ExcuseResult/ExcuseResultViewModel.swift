//
//  ExcuseResultViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 29.10.2021.
//  
//

import Combine

final class ExcuseResultViewModel {
    // MARK: - ViewModelType

    struct Dependency {
        let excuse: String
    }

    struct Bindings {
        let homeTap: AnyPublisher<Void, Never>
    }

    // MARK: - ViewController Bindings

    private(set) var excuse = CurrentValueSubject<String, Never>("")

    // MARK: - Coordinator Bindings

    private(set) var homeTapped: AnyPublisher<Void, Never>!

    // MARK: - Variables

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization

    init(dependency: Dependency, bindings: Bindings) {
        setupActions(dependency: dependency, bindings: bindings)
        setupDataUpdates(dependency: dependency, bindings: bindings)
    }

    func setupActions(dependency: Dependency, bindings: Bindings) {
        homeTapped = bindings.homeTap
    }

    func setupDataUpdates(dependency: Dependency, bindings: Bindings) {
        excuse.send(dependency.excuse)
    }
}
