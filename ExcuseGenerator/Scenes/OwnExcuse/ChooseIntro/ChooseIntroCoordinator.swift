//
//  ChooseIntroCoordinator.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 26.10.2021.
//

import Combine
import CoordinatorRouter

final class ChooseIntroCoordinator: BaseCoordinator<RouterResult<Void>> {
    typealias Dependencies = AllDependencies

    private let router: Router
    private let dependencies: Dependencies

    init(router: Router, dependencies: Dependencies) {
        self.router = router
        self.dependencies = dependencies
    }

    override func start() -> AnyPublisher<CoordinationResult, Never> {
        Empty<CoordinationResult, Never>().eraseToAnyPublisher()
//        let viewData = ChooseIntroView.ViewData()
//        let view = ChooseIntroView(viewData: viewData)
//        let viewController = ChooseIntroViewController(viewData: viewData, rootView: view)
//        let viewModel = viewController.attach(wrapper: ViewModelWrapper<ChooseIntroViewModel>(dependencies))
//
//        router.present(viewController, animated: true)
//
//        let finished = viewModel.buttonTapped
//            .flatMap { [weak self]  intro -> AnyPublisher<RouterResult<Void>, Never> in
//                guard let self = self else { return Empty<RouterResult<Void>, Never>(completeImmediately: true).eraseToAnyPublisher() }
//                return self.showChooseMedium(router: self.router, intro: intro)
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

extension ChooseIntroCoordinator {
    private func showChooseMedium(router: Router, intro: String) -> AnyPublisher<RouterResult<Void>, Never> {
        coordinate(to: ChooseMediumCoordinator(router: router, dependencies: dependencies, intro: intro))
    }
}
