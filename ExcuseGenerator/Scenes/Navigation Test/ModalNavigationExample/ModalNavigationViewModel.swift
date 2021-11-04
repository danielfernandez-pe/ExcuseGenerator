//
//  ModalNavigationViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 24.10.2021.
//

import Combine

final class ModalNavigationViewModel: ViewModelType {
    // MARK: - ViewModelType

    typealias Dependency = HasDummyManager

    struct Bindings {
        let pushTap: AnyPublisher<Void, Never>
        let closeTap: AnyPublisher<Void, Never>
    }

    // MARK: - Coordinator Bindings

    private(set) var pushTapped: AnyPublisher<Void, Never>!
    private(set) var closeTapped: AnyPublisher<Void, Never>!

    // MARK: - Variables

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization

    init(dependency: Dependency, bindings: Bindings) {
        setupActions(dependency: dependency, bindings: bindings)
        setupDataUpdates(dependency: dependency, bindings: bindings)
    }

    func setupActions(dependency: Dependency, bindings: Bindings) {
        pushTapped = bindings.pushTap
        closeTapped = bindings.closeTap
    }

    func setupDataUpdates(dependency: Dependency, bindings: Bindings) {
    }
}
