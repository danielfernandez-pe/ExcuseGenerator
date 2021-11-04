//
//  Test2Coordinator.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 24.10.2021.
//

import Combine
import CoordinatorRouter

final class Test2Coordinator: BaseCoordinator<RouterResult<Void>> {
    typealias Dependencies = AllDependencies

    private let router: Router
    private let dependencies: Dependencies

    init(router: Router, dependencies: Dependencies) {
        self.router = router
        self.dependencies = dependencies
    }

    override func start() -> AnyPublisher<CoordinationResult, Never> {
        let viewController = Test2ViewController.create()
        let viewModel = viewController.attach(wrapper: ViewModelWrapper<Test2ViewModel>(dependencies))

        router.present(viewController, animated: true)

        let popTapped = viewModel.popTapped
            .compactMap { [weak self] _ -> RouterResult<Void>? in
                guard let self = self else { return nil }
                return RouterResult<Void>.popped(router: self.router)
            }

        let finished = viewModel.finishTapped
            .compactMap { [weak self] _ -> RouterResult<Void>? in
                guard let self = self else { return nil }
                return RouterResult<Void>.finished(router: self.router, value: ())
            }

        let dismissed = dismissObservable(from: viewController, router: router)
            .filter { $0 == viewController }
            .map { _ in RouterResult<Void>.dismissedByRouter }

        return popTapped.merge(with: finished, dismissed)
            .prefix(1)
            .eraseToAnyPublisher()
    }
}
