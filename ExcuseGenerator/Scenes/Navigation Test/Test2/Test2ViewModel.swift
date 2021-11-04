//
//  Test2ViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 24.10.2021.
//

import Combine

final class Test2ViewModel: ViewModelType {
    // MARK: - ViewModelType

    typealias Dependency = HasDummyManager

    struct Bindings {
        let popTap: AnyPublisher<Void, Never>
        let finishTap: AnyPublisher<Void, Never>
    }

    // MARK: - Coordinator Bindings

    private(set) var popTapped: AnyPublisher<Void, Never>!
    private(set) var finishTapped: AnyPublisher<Void, Never>!

    // MARK: - Variables

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization

    init(dependency: Dependency, bindings: Bindings) {
        setupActions(dependency: dependency, bindings: bindings)
        setupDataUpdates(dependency: dependency, bindings: bindings)
    }

    func setupActions(dependency: Dependency, bindings: Bindings) {
        popTapped = bindings.popTap
        finishTapped = bindings.finishTap
    }

    func setupDataUpdates(dependency: Dependency, bindings: Bindings) {
    }
}
