//
//  PremiumContentCoordinator.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 11.07.2022.
//

import Combine
import CoordinatorRouter

final class PremiumContentCoordinator: BaseCoordinator<RouterResult<Void>> {
    typealias Dependencies = AllDependencies

    private let router: Router
    private let dependencies: Dependencies

    init(router: Router, dependencies: Dependencies) {
        self.router = router
        self.dependencies = dependencies
    }

    override func start() -> AnyPublisher<CoordinationResult, Never> {
        let viewModel = PremiumContentViewModel()
        let viewController = BaseViewController(rootView: PremiumContentView(viewModel: viewModel))

        router.present(viewController, animated: true)

        let dismissed = dismissObservable(with: viewController, dismissHandler: router)
            .map { _ in RouterResult<Void>.dismissedByRouter }

        return dismissed
            .eraseToAnyPublisher()
    }
}
