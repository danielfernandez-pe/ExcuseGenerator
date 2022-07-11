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
        let viewData = SubscriptionsView.ViewData()
        let view = SubscriptionsView(viewData: viewData)
        let viewController = SubscriptionsViewController(viewData: viewData, rootView: view)
        let viewModel = viewController.attach(wrapper: ViewModelWrapper<SubscriptionsViewModel>(dependencies))

        router.present(viewController, animated: true)

        let dismissed = dismissObservable(from: viewController, router: router)
            .filter { $0 == viewController }
            .map { _ in RouterResult<Void>.dismissedByRouter }

        let closeTapped = viewModel.closeTapped
            .compactMap { [weak self] _ -> RouterResult<Void>? in
                guard let self = self else { return nil }
                return RouterResult<Void>.dismiss(router: self.router)
            }

        return dismissed.merge(with: closeTapped)
            .eraseToAnyPublisher()
    }
}

extension SubscriptionsCoordinator {
    private func showChooseMedium(router: Router, intro: String) -> AnyPublisher<RouterResult<Void>, Never> {
        coordinate(to: ChooseMediumCoordinator(router: router, dependencies: dependencies, intro: intro))
    }
}
