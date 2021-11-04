//
//  HomeViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 23.10.2021.
//

import Combine

final class Home2ViewModel: ViewModelType {
    // MARK: - ViewModelType

    typealias Dependency = HasDummyManager

    struct Bindings {
        let modalNavigationTap: AnyPublisher<Void, Never>
        let modalTap: AnyPublisher<Void, Never>
        let navigationTap: AnyPublisher<Void, Never>
    }

    // MARK: - Coordinator Bindings

    private(set) var modalNavigationTapped: AnyPublisher<Void, Never>!

    // MARK: - Initialization

    init(dependency: Dependency, bindings: Bindings) {
        setupActions(dependency: dependency, bindings: bindings)
        setupDataUpdates(dependency: dependency, bindings: bindings)
    }

    func setupActions(dependency: Dependency, bindings: Bindings) {
        modalNavigationTapped = bindings.modalNavigationTap
    }

    func setupDataUpdates(dependency: Dependency, bindings: Bindings) {
    }
}
