//
//  ExcuseResultCoordinator.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 29.10.2021.
//  
//

import Combine
import CoordinatorRouter

final class ExcuseResultCoordinator: BaseCoordinator<RouterResult<Void>> {
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
//        let viewData = ExcuseResultView.ViewData()
//        let view = ExcuseResultView(viewData: viewData)
//        let viewController = ExcuseResultViewController(viewData: viewData, rootView: view)
//        let viewModel = viewController.attach(wrapper: ViewModelWrapper<ExcuseResultViewModel>(.init(excuse: excuse)))
//
//        router.present(viewController, animated: true)
//
//        let finished = viewModel.homeTapped
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
