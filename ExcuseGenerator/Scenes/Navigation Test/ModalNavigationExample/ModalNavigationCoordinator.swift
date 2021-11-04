//
//  ModalNavigationCoordinator.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 24.10.2021.
//

import Combine
import CoordinatorRouter

final class ModalNavigationCoordinator: BaseCoordinator<RouterResult<Void>> {
    typealias Dependencies = AllDependencies

    private let router: Router
    private let dependencies: Dependencies

    init(router: Router, dependencies: Dependencies) {
        self.router = router
        self.dependencies = dependencies
    }

    deinit {
        print("ModalNavigationCoordinator deinit")
    }

    override func start() -> AnyPublisher<CoordinationResult, Never> {
        let viewController = ModalNavigationViewController.create()
        let viewModel = viewController.attach(wrapper: ViewModelWrapper<ModalNavigationViewModel>(dependencies))

        router.present(viewController, animated: true)

        let finished = viewModel.pushTapped
            .flatMap { [weak self] _ -> AnyPublisher<RouterResult<Void>, Never> in
                guard let self = self else { return Empty<RouterResult<Void>, Never>(completeImmediately: true).eraseToAnyPublisher() }
                return self.showTest(router: self.router)
            }
            .handleEvents(receiveOutput: { result in
                switch result {
                case let .finished(router, _):
                    router.dismiss(animated: true)
                default:
                    break
                }
            })
            .filter { [weak self] result in
                guard let self = self else { return false }
                return result == .finished(router: self.router, value: ())
            }
            .compactMap { $0.mapFinished { _ in () } }

        let closeTapped = viewModel.closeTapped
            .compactMap { [weak self] _ -> RouterResult<Void>? in
                guard let self = self else { return nil }
                return RouterResult<Void>.dismiss(router: self.router)
            }

        return closeTapped.merge(with: finished)
            .prefix(1)
            .eraseToAnyPublisher()
    }
}

extension ModalNavigationCoordinator {
    private func showTest(router: Router) -> AnyPublisher<RouterResult<Void>, Never> {
        coordinate(to: TestCoordinator(router: router, dependencies: dependencies))
    }
}
