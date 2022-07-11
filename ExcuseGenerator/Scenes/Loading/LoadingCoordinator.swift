//
//  LoadingCoordinator.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 29.10.2021.
//  
//

import Combine
import CoordinatorRouter

final class LoadingCoordinator: BaseCoordinator<RouterResult<Void>> {
    typealias Dependencies = AllDependencies

    private let router: Router
    private let dependencies: Dependencies
    private let excuse: String

    init(router: Router, dependencies: Dependencies, excuse: String) {
        self.router = router
        self.dependencies = dependencies
        self.excuse = excuse
    }

    override func start() -> AnyPublisher<CoordinationResult, Never> {
        Empty<CoordinationResult, Never>().eraseToAnyPublisher()
//        let viewData = LoadingView.ViewData()
//        let view = LoadingView(viewData: viewData)
//        let viewController = LoadingViewController(viewData: viewData, rootView: view)
//        let viewModel = viewController.attach(wrapper: ViewModelWrapper<LoadingViewModel>(dependencies))
//
//        router.present(viewController, animated: true)
//
//        let finished = viewModel.animationFinished
//            .flatMap { [weak self] _ -> AnyPublisher<RouterResult<Void>, Never> in
//                guard let self = self else { return Empty<RouterResult<Void>, Never>(completeImmediately: true).eraseToAnyPublisher() }
//                return self.showExcuseResult(router: self.router, excuse: self.excuse)
//            }
//            .filter { if case .finished = $0 { return true } else { return false } }
//            .compactMap { [weak self] _ -> RouterResult<Void>? in
//                guard let self = self else { return nil }
//                return RouterResult<Void>.finished(())
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

extension LoadingCoordinator {
    private func showExcuseResult(router: Router, excuse: String) -> AnyPublisher<RouterResult<Void>, Never> {
        coordinate(to: ExcuseResultCoordinator(router: router, dependencies: dependencies, excuse: excuse))
    }
}
