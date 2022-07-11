//
//  ChooseIntroViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 26.10.2021.
//

import Combine
import Foundation

final class ChooseIntroViewModel {
    // MARK: - ViewModelType

    typealias Dependency = HasExcuseService

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
    }

    func setupDataUpdates(dependency: Dependency, bindings: Bindings) {
        state.send(.content(dependency.excuseService.excuses(for: .intro)))
    }
}
