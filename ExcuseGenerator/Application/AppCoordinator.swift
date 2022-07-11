//
//  AppCoordinator.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 23.10.2021.
//

import UIKit
import Combine
import CoordinatorRouter

final class AppCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow
    private let dependencies: AppDependency

    init(window: UIWindow) {
        self.window = window
        self.dependencies = AppDependency()
    }

    override func start() -> AnyPublisher<Void, Never> {
        coordinateToRoot()
        return Empty<Void, Never>(completeImmediately: false).eraseToAnyPublisher()
    }

    private func coordinateToRoot() {
        showHome()
            .sink(receiveCompletion: { [weak self] _ in
                self?.resetFlow()
            }, receiveValue: {})
            .store(in: cancelBag)
    }

    private func resetFlow() {
        window.rootViewController = nil
        coordinateToRoot()
    }
}

extension AppCoordinator {
    private func showHome() -> AnyPublisher<Void, Never> {
        coordinate(to: HomeCoordinator(window: window, dependencies: dependencies))
    }
}
