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
        let viewModel = HomeViewModel(iapManager: dependencies.iapManager, excuseService: dependencies.excuseService)
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

        viewModel.openPremiumContent
            .flatMap { [weak self] _ -> AnyPublisher<RouterResult<Void>, Never> in
                guard let self = self else { return Empty<RouterResult<Void>, Never>(completeImmediately: true).eraseToAnyPublisher() }
                return self.showPremiumContent(router: NavigationRouter(navigationController: navigationController))
            }
            .sink(receiveValue: { _ in })
            .store(in: cancelBag)

        if #available(iOS 16, *) {
            viewModel.openSubscriptions
                .flatMap { [weak self] _ -> AnyPublisher<RouterResult<Void>, Never> in
                    guard let self = self else { return Empty<RouterResult<Void>, Never>(completeImmediately: true).eraseToAnyPublisher() }
                    let modalRouter = ModalNavigationRouter(parentViewController: viewController, presentationStyle: .fullScreen)
                    return self.showSubscriptions16(router: modalRouter)
                }
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
        } else if #available(iOS 15, *) {
            viewModel.openSubscriptions
                .flatMap { [weak self] _ -> AnyPublisher<RouterResult<Void>, Never> in
                    guard let self = self else { return Empty<RouterResult<Void>, Never>(completeImmediately: true).eraseToAnyPublisher() }
                    let modalRouter = ModalNavigationRouter(parentViewController: viewController, presentationStyle: .fullScreen)
                    return self.showSubscriptionsSk2(router: modalRouter)
                }
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
        } else {
            viewModel.openSubscriptions
                .flatMap { [weak self] _ -> AnyPublisher<RouterResult<Void>, Never> in
                    guard let self = self else { return Empty<RouterResult<Void>, Never>(completeImmediately: true).eraseToAnyPublisher() }
                    let modalRouter = ModalNavigationRouter(parentViewController: viewController, presentationStyle: .fullScreen)
                    return self.showSubscriptions(router: modalRouter)
                }
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
        }

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

    @available(iOS 15, *)
    private func showSubscriptionsSk2(router: Router) -> AnyPublisher<RouterResult<Void>, Never> {
        coordinate(to: SubscriptionsSk2Coordinator(router: router, dependencies: dependencies))
            .flatMap { result -> CoordinatingResult<RouterResult<Void>> in
                guard result != .dismissedByRouter else {
                    return Just(result).eraseToAnyPublisher()
                }
                return router.dismiss(animated: true, returning: result)
            }
            .prefix(1)
            .eraseToAnyPublisher()
    }

    @available(iOS 16, *)
    private func showSubscriptions16(router: Router) -> AnyPublisher<RouterResult<Void>, Never> {
        coordinate(to: Subscriptions16Coordinator(router: router, dependencies: dependencies))
            .flatMap { result -> CoordinatingResult<RouterResult<Void>> in
                guard result != .dismissedByRouter else {
                    return Just(result).eraseToAnyPublisher()
                }
                return router.dismiss(animated: true, returning: result)
            }
            .prefix(1)
            .eraseToAnyPublisher()
    }

    private func showPremiumContent(router: Router) -> AnyPublisher<RouterResult<Void>, Never> {
        coordinate(to: PremiumContentCoordinator(router: router, dependencies: dependencies))
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
