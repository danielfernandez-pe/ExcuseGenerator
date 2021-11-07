//
//  LoadingViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 29.10.2021.
//  
//

import Foundation
import Combine

final class LoadingViewModel: ViewModelType {
    // MARK: - ViewModelType

    typealias Dependency = HasDummyManager

    struct Bindings {
    }

    // MARK: - Coordinator Bindings

    private(set) var animationFinished: AnyPublisher<Void, Never>!

    // MARK: - Variables

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialization

    init(dependency: Dependency, bindings: Bindings) {
        setupDataUpdates(dependency: dependency, bindings: bindings)
    }

    func setupDataUpdates(dependency: Dependency, bindings: Bindings) {
        animationFinished = Just(())
            .delay(for: .seconds(2), scheduler: RunLoop.main, options: .none)
            .eraseToAnyPublisher()
    }
}
