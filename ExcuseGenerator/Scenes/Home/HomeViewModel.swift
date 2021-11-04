//
//  HomeViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 26.10.2021.
//

import Combine

final class HomeViewModel: ViewModelType {
    // MARK: - ViewModelType

    typealias Dependency = HasExcuseService

    struct Bindings {
        let giveExcuseTap: AnyPublisher<Void, Never>
        let createOwnExcuseTap: AnyPublisher<Void, Never>
    }

    // MARK: - Coordinator Bindings

    private(set) var giveExcuseTapped: AnyPublisher<String, Never>!
    private(set) var createOwnExcuseTapped: AnyPublisher<Void, Never>!

    // MARK: - Initialization

    init(dependency: Dependency, bindings: Bindings) {
        setupActions(dependency: dependency, bindings: bindings)
    }

    func setupActions(dependency: Dependency, bindings: Bindings) {
        giveExcuseTapped = bindings.giveExcuseTap
            .map { dependency.excuseService.getRandomExcuse() }
            .eraseToAnyPublisher()
        createOwnExcuseTapped = bindings.createOwnExcuseTap
    }
}
