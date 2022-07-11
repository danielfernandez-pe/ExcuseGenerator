//
//  ChooseMediumViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 29.10.2021.
//  
//

import Combine

final class ChooseMediumViewModel {
    // MARK: - ViewModelType

    struct Dependency {
        let excuseService: ExcuseServiceType
        let intro: String
    }

    struct Bindings {
        let buttonTap: AnyPublisher<String, Never>
    }

    // MARK: - ViewController Bindings

    private(set) var state = CurrentValueSubject<ChooseState, Never>(.loading)

    // MARK: - Coordinator Bindings

    private(set) var buttonTapped: AnyPublisher<String, Never>!

    // MARK: - Variables

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization

    init(dependency: Dependency, bindings: Bindings) {
        setupActions(dependency: dependency, bindings: bindings)
        setupDataUpdates(dependency: dependency, bindings: bindings)
    }

    func setupActions(dependency: Dependency, bindings: Bindings) {
        buttonTapped = bindings.buttonTap
            .map { "\(dependency.intro) \($0)" }
            .eraseToAnyPublisher()
    }

    func setupDataUpdates(dependency: Dependency, bindings: Bindings) {
        state.send(.content(dependency.excuseService.excuses(for: .scapegoat)))
    }
}
