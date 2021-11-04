//
//  TestCoordinator.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 24.10.2021.
//

import Combine
import CoordinatorRouter

final class TestCoordinator: BaseCoordinator<RouterResult<Void>> {
    typealias Dependencies = AllDependencies

    private let router: Router
    private let dependencies: Dependencies

    init(router: Router, dependencies: Dependencies) {
        self.router = router
        self.dependencies = dependencies
    }

    deinit {
        print("TestCoordinator deinit")
    }

    override func start() -> AnyPublisher<CoordinationResult, Never> {
        let viewController = TestViewController.create()
        let viewModel = viewController.attach(wrapper: ViewModelWrapper<TestViewModel>(dependencies))

        router.present(viewController, animated: true)

        let finished = viewModel.pushTapped
            .flatMap { [weak self] _ -> AnyPublisher<RouterResult<Void>, Never> in
                guard let self = self else { return Empty<RouterResult<Void>, Never>(completeImmediately: true).eraseToAnyPublisher() }
                return self.showTest2(router: self.router)
            }
            .handleEvents(receiveOutput: { result in
                switch result {
                case let .popped(router):
                    router.pop()
                default:
                    break
                }
            })
            .filter { [weak self] result in
                guard let self = self else { return false }
                return result == .finished(router: self.router, value: ())
            }
            .compactMap { $0.mapFinished { _ in () } }

        let dismissed = dismissObservable(from: viewController, router: router)
            .filter { $0 == viewController }
            .map { _ in RouterResult<Void>.dismissedByRouter }

        return dismissed.merge(with: finished)
            .prefix(1)
            .eraseToAnyPublisher()
    }
}

extension TestCoordinator {
    private func showTest2(router: Router) -> AnyPublisher<RouterResult<Void>, Never> {
        coordinate(to: Test2Coordinator(router: router, dependencies: dependencies))
    }
}
