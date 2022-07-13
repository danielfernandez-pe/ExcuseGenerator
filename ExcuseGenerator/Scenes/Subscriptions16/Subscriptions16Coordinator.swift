//
//  Subscriptions16Coordinator.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 12.07.2022.
//

import Combine
import CoordinatorRouter

@available(iOS 16, *)
final class Subscriptions16Coordinator: BaseCoordinator<RouterResult<Void>> {
    typealias Dependencies = AllDependencies

    private let router: Router
    private let dependencies: Dependencies

    init(router: Router, dependencies: Dependencies) {
        self.router = router
        self.dependencies = dependencies
    }

    override func start() -> AnyPublisher<CoordinationResult, Never> {
        let viewModel = Subscriptions16ViewModel(iapManager: AppDependencySk2.iapManagerSk2)
        let viewController = BaseViewController(rootView: Susbcriptions16View(viewModel: viewModel))

        router.present(viewController, animated: true)

        let dismissed = dismissObservable(with: viewController, dismissHandler: router)
            .map { _ in RouterResult<Void>.dismissedByRouter }

        let closeTapped = viewModel.closeTap
            .map { _ in RouterResult<Void>.dismiss }

        viewModel.showTransactions
            .flatMap { [weak self] _ -> AnyPublisher<RouterResult<Void>, Never> in
                guard let self = self else { return Empty<RouterResult<Void>, Never>(completeImmediately: true).eraseToAnyPublisher() }
                return self.showTransactions(router: self.router)
            }
            .sink(receiveValue: { _ in })
            .store(in: cancelBag)

        return dismissed.merge(with: closeTapped)
            .eraseToAnyPublisher()
    }
}

@available(iOS 16, *)
extension Subscriptions16Coordinator {
    private func showTransactions(router: Router) -> AnyPublisher<RouterResult<Void>, Never> {
        coordinate(to: TransactionsCoordinator(router: router, dependencies: dependencies))
            .flatMap { result -> CoordinatingResult<RouterResult<Void>> in
                guard result != .dismissedByRouter else {
                    return Just(result).eraseToAnyPublisher()
                }
                return router.dismiss(animated: true, returning: result)
            }
            .prefix(1)
            .eraseToAnyPublisher()
    }
}
