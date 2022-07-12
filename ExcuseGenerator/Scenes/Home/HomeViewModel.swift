//
//  HomeViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 26.10.2021.
//

import Combine
import CoordinatorRouter

final class HomeViewModel: ObservableObject {
    @Published var isUserPremium = false

    let openSubscriptions = PassthroughSubject<Void, Never>()
    let removeSubscriptions = PassthroughSubject<Void, Never>()
    let openPremiumContent = PassthroughSubject<Void, Never>()

    private let iapManagerUserPremium: IapManagerUserPremium
    private let excuseService: ExcuseServiceType
    private let cancelBag: CancelBag = .init()

//    struct Bindings {
//        let giveExcuseTap: AnyPublisher<Void, Never>
//        let createOwnExcuseTap: AnyPublisher<Void, Never>
//        let subscriptionsTap: AnyPublisher<Void, Never>
//    }

    // MARK: - Coordinator Bindings

//    private(set) var giveExcuseTapped: AnyPublisher<String, Never>!
//    private(set) var createOwnExcuseTapped: AnyPublisher<Void, Never>!
//    private(set) var subscriptionsTapped: AnyPublisher<Void, Never>!

    // MARK: - Initialization

    init(iapManagerUserPremium: IapManagerUserPremium, excuseService: ExcuseServiceType) {
        self.iapManagerUserPremium = iapManagerUserPremium
        self.excuseService = excuseService
        setupActions()
    }

    func setupActions() {
        removeSubscriptions
            .sink { _ in
                UserDefaultsConfig.iapProductIdentifiers = []
                UserDefaultsConfig.iapUserIsPremium = false
                print("userIsPremium is \(UserDefaultsConfig.iapUserIsPremium)")
            }
            .store(in: cancelBag)

        iapManagerUserPremium.isUserPremium
            .print("home")
            .assign(to: &$isUserPremium)
//        giveExcuseTapped = bindings.giveExcuseTap
//            .map { dependency.excuseService.getRandomExcuse() }
//            .eraseToAnyPublisher()
//        createOwnExcuseTapped = bindings.createOwnExcuseTap
//        subscriptionsTapped = bindings.subscriptionsTap
    }
}
