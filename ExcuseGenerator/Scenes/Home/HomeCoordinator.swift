//
//  HomeCoordinator.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 26.10.2021.
//

import UIKit
import Combine
import CoordinatorRouter

final class HomeCoordinator: BaseCoordinator<Void> {
    typealias Dependencies = AllDependencies

    private let window: UIWindow
    private let dependencies: Dependencies

    init(window: UIWindow, dependencies: Dependencies) {
        self.window = window
        self.dependencies = dependencies
    }

    override func start() -> AnyPublisher<CoordinationResult, Never> {
        let viewModel = HomeViewModel(excuseService: ExcuseService())
        let viewController = BaseViewController(rootView: HomeView(viewModel: viewModel))
        let navigationController = NavigationController(rootViewController: viewController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

//        viewModel.createOwnExcuseTapped
//            .flatMap { [weak self] _ -> AnyPublisher<RouterResult<Void>, Never> in
//                guard let self = self else { return Empty<RouterResult<Void>, Never>(completeImmediately: true).eraseToAnyPublisher() }
//                let navigationRouter = NavigationRouter(navigationController: navigationController)
//                return self.showChooseIntro(router: navigationRouter)
//            }
//            .sink(receiveValue: { result in
//                switch result {
//                case .finished(let router, _):
//                    router.popToRoot()
//                default:
//                    break
//                }
//            })
//            .store(in: cancelBag)

//        viewModel.giveExcuseTapped
//            .flatMap { [weak self] excuse -> AnyPublisher<RouterResult<Void>, Never> in
//                guard let self = self else { return Empty<RouterResult<Void>, Never>(completeImmediately: true).eraseToAnyPublisher() }
//                let navigationRouter = NavigationRouter(navigationController: navigationController)
//                return self.showLoading(router: navigationRouter, excuse: excuse)
//            }
//            .sink(receiveValue: { result in
//                switch result {
//                case .finished(_):
//                    router.popToRoot()
//                default:
//                    break
//                }
//            })
//            .store(in: cancelBag)

        viewModel.openSubscriptions
            .flatMap { [weak self] _ -> AnyPublisher<RouterResult<Void>, Never> in
                guard let self = self else { return Empty<RouterResult<Void>, Never>(completeImmediately: true).eraseToAnyPublisher() }
                let modalRouter = ModalNavigationRouter(parentViewController: viewController, presentationStyle: .fullScreen)
                return self.showSubscriptions(router: modalRouter)
            }
            .sink(receiveValue: { _ in })
            .store(in: cancelBag)

        return Empty<CoordinationResult, Never>(completeImmediately: false).eraseToAnyPublisher()
    }
}

extension HomeCoordinator {
    private func showChooseIntro(router: Router) -> AnyPublisher<RouterResult<Void>, Never> {
        coordinate(to: ChooseIntroCoordinator(router: router, dependencies: dependencies))
    }

    private func showLoading(router: Router, excuse: String) -> AnyPublisher<RouterResult<Void>, Never> {
        coordinate(to: LoadingCoordinator(router: router, dependencies: dependencies, excuse: excuse))
    }

    private func showSubscriptions(router: Router) -> AnyPublisher<RouterResult<Void>, Never> {
        coordinate(to: SubscriptionsCoordinator(router: router, dependencies: dependencies))
            .flatMap { result -> CoordinatingResult<RouterResult<Void>> in
                guard result != .dismissedByRouter else {
                    return Just(result).eraseToAnyPublisher()
                }
                return router.dismiss(animated: true, returning: result)
            }
            .prefix(1)
            .eraseToAnyPublisher()
    }
}
