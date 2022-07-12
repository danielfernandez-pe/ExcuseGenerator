//
//  SubscriptionsSk2Coordinator.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 12.07.2022.
//

import Combine
import CoordinatorRouter

@available(iOS 15, *)
final class SubscriptionsSk2Coordinator: BaseCoordinator<RouterResult<Void>> {
    typealias Dependencies = AllDependencies

    private let router: Router
    private let dependencies: Dependencies

    init(router: Router, dependencies: Dependencies) {
        self.router = router
        self.dependencies = dependencies
    }

    override func start() -> AnyPublisher<CoordinationResult, Never> {
        let viewModel = SubscriptionsSk2ViewModel(iapManager: IapManagerStoreKit2())
        let viewController = BaseViewController(rootView: SubscriptionsSk2View(viewModel: viewModel))

        router.present(viewController, animated: true)

        let dismissed = dismissObservable(with: viewController, dismissHandler: router)
            .map { _ in RouterResult<Void>.dismissedByRouter }

        let closeTapped = viewModel.closeTap
            .map { _ in RouterResult<Void>.dismiss }

        return dismissed.merge(with: closeTapped)
            .eraseToAnyPublisher()
    }
}
