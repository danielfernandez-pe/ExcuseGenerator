//
//  ChooseEndingCoordinator.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 29.10.2021.
//  
//

import Combine
import CoordinatorRouter

final class ChooseEndingCoordinator: BaseCoordinator<RouterResult<Void>> {
    typealias Dependencies = AllDependencies

    private let router: Router
    private let dependencies: Dependencies
    private let scapegoat: String

    init(router: Router, dependencies: Dependencies, scapegoat: String) {
        self.router = router
        self.dependencies = dependencies
        self.scapegoat = scapegoat
    }

    override func start() -> AnyPublisher<CoordinationResult, Never> {
        Empty<CoordinationResult, Never>().eraseToAnyPublisher()
//        let viewData = ChooseEndingView.ViewData()
//        let view = ChooseEndingView(viewData: viewData)
//        let viewController = ChooseEndingViewController(viewData: viewData, rootView: view)
//        let viewModel = viewController.attach(
//            wrapper: ViewModelWrapper<ChooseEndingViewModel>(
//                .init(
//                    excuseService: dependencies.excuseService,
//                    scapegoat: scapegoat
//                )
//            )
//        )
//
//        router.present(viewController, animated: true)
//
//        let finished = viewModel.buttonTapped
//            .flatMap { [weak self] excuse -> AnyPublisher<RouterResult<Void>, Never> in
//                guard let self = self else { return Empty<RouterResult<Void>, Never>(completeImmediately: true).eraseToAnyPublisher() }
//                return self.showLoading(router: self.router, excuse: excuse)
//            }
//            .filter { if case .finished = $0 { return true } else { return false } }
//            .compactMap { [weak self] _ -> RouterResult<Void>? in
//                guard let self = self else { return nil }
//                return RouterResult<Void>.finished(router: self.router, value: ())
//            }
//
//        let dismissed = dismissObservable(from: viewController, router: router)
//            .filter { $0 == viewController }
//            .map { _ in RouterResult<Void>.dismissedByRouter }
//
//        return dismissed.merge(with: finished)
//            .prefix(1)
//            .eraseToAnyPublisher()
    }
}

extension ChooseEndingCoordinator {
    private func showLoading(router: Router, excuse: String) -> AnyPublisher<RouterResult<Void>, Never> {
        coordinate(to: LoadingCoordinator(router: router, dependencies: dependencies, excuse: excuse))
    }
}
