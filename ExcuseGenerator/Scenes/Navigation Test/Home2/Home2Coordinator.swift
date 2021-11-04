//
//  HomeCoordinator.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 23.10.2021.
//

import UIKit
import Combine
import CoordinatorRouter

final class Home2Coordinator: BaseCoordinator<Void> {
    typealias Dependencies = AllDependencies

    private let window: UIWindow
    private let dependencies: Dependencies

    init(window: UIWindow, dependencies: Dependencies) {
        self.window = window
        self.dependencies = dependencies
    }

    override func start() -> AnyPublisher<CoordinationResult, Never> {
        let viewController = Home2ViewController.create()
        let viewModel = viewController.attach(wrapper: ViewModelWrapper<Home2ViewModel>(dependencies))

        window.rootViewController = viewController
        window.makeKeyAndVisible()

        viewModel.modalNavigationTapped
            .flatMap { [weak self] _ -> AnyPublisher<RouterResult<Void>, Never> in
                guard let self = self else { return Empty<RouterResult<Void>, Never>(completeImmediately: true).eraseToAnyPublisher() }
                let modalNavigationRouter = ModalNavigationRouter(
                    parentViewController: viewController,
                    presentationStyle: .formSheet,
                    transitionStyle: nil
                )
                return self.showModalNavigation(router: modalNavigationRouter)
            }
            .sink(receiveValue: { result in
                switch result {
                case let .dismiss(router):
                    router.dismiss(animated: true)
                case let .finished(router, _):
                    router.dismiss(animated: true)
                default:
                    break
                }
            })
            .store(in: &cancellables)

        return Empty<CoordinationResult, Never>(completeImmediately: false).eraseToAnyPublisher()
    }
}

extension Home2Coordinator {
    private func showModalNavigation(router: Router) -> AnyPublisher<RouterResult<Void>, Never> {
        coordinate(to: ModalNavigationCoordinator(router: router, dependencies: dependencies))
    }
}
