//
//  ChooseMediumCoordinator.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 29.10.2021.
//  
//

import Combine
import CoordinatorRouter

final class ChooseMediumCoordinator: BaseCoordinator<RouterResult<Void>> {
    typealias Dependencies = AllDependencies

    private let router: Router
    private let dependencies: Dependencies
    private let intro: String

    init(router: Router, dependencies: Dependencies, intro: String) {
        self.router = router
        self.dependencies = dependencies
        self.intro = intro
    }

    override func start() -> AnyPublisher<CoordinationResult, Never> {
        Empty<CoordinationResult, Never>().eraseToAnyPublisher()
//        let view = ChooseMediumView()
//        let viewController = BaseViewController(rootView: view)
//        let viewModel = viewController.attach(
//            wrapper: ViewModelWrapper<ChooseMediumViewModel>(
//                .init(
//                    excuseService: dependencies.excuseService,
//                    intro: intro
//                )
//            )
//        )
//
//        router.present(viewController, animated: true)
//
//        let finished = viewModel.buttonTapped
//            .flatMap { [weak self]  scapegoat -> AnyPublisher<RouterResult<Void>, Never> in
//                guard let self = self else { return Empty<RouterResult<Void>, Never>(completeImmediately: true).eraseToAnyPublisher() }
//                return self.showChooseEnding(router: self.router, scapegoat: scapegoat)
//            }
//            .filter { if case .finished = $0 { return true } else { return false } }
//            .compactMap { [weak self] _ -> RouterResult<Void>? in
//                guard let self = self else { return nil }
//                return RouterResult<Void>.finished(())
//            }
//
//        let dismissed = dismissObservable(with: viewController, dismissHandler: router)
//            .filter { $0 == viewController }
//            .map { _ in RouterResult<Void>.dismissedByRouter }
//
//        return dismissed.merge(with: finished)
//            .prefix(1)
//            .eraseToAnyPublisher()
    }
}

extension ChooseMediumCoordinator {
    private func showChooseEnding(router: Router, scapegoat: String) -> AnyPublisher<RouterResult<Void>, Never> {
        coordinate(to: ChooseEndingCoordinator(router: router, dependencies: dependencies, scapegoat: scapegoat))
    }
}
