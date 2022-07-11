//
//  SubscriptionsCoordinator.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 09.07.2022.
//

import Combine
import CoordinatorRouter

final class SubscriptionsCoordinator: BaseCoordinator<RouterResult<Void>> {
    typealias Dependencies = AllDependencies

    private let router: Router
    private let dependencies: Dependencies

    init(router: Router, dependencies: Dependencies) {
        self.router = router
        self.dependencies = dependencies
    }

    override func start() -> AnyPublisher<CoordinationResult, Never> {
        let viewModel = SubscriptionsViewModel(iapManager: IapManager(), iapService: IapService())
        let viewController = BaseViewController(rootView: SubscriptionsView(viewModel: viewModel))

        router.present(viewController, animated: true)

        let dismissed = dismissObservable(with: viewController, dismissHandler: router)
            .map { _ in RouterResult<Void>.dismissedByRouter }

        let closeTapped = viewModel.closeTap
            .map { _ in RouterResult<Void>.dismiss }

        return dismissed.merge(with: closeTapped)
            .eraseToAnyPublisher()
    }
}

extension SubscriptionsCoordinator {
    private func showChooseMedium(router: Router, intro: String) -> AnyPublisher<RouterResult<Void>, Never> {
        coordinate(to: ChooseMediumCoordinator(router: router, dependencies: dependencies, intro: intro))
    }
}
