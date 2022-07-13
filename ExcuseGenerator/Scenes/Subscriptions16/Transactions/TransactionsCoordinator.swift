//
//  TransactionsCoordinator.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 13.07.2022.
//

import Combine
import CoordinatorRouter

@available(iOS 16, *)
final class TransactionsCoordinator: BaseCoordinator<RouterResult<Void>> {
    typealias Dependencies = AllDependencies

    private let router: Router
    private let dependencies: Dependencies

    init(router: Router, dependencies: Dependencies) {
        self.router = router
        self.dependencies = dependencies
    }

    override func start() -> AnyPublisher<CoordinationResult, Never> {
        let viewModel = TransactionsViewModel(iapManager: AppDependencySk2.iapManagerSk2)
        let viewController = BaseViewController(rootView: TransactionsView(viewModel: viewModel))

        router.present(viewController, animated: true)

        let dismissed = dismissObservable(with: viewController, dismissHandler: router)
            .map { _ in RouterResult<Void>.dismissedByRouter }

        return dismissed
            .eraseToAnyPublisher()
    }
}
