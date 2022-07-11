//
//  HomeViewModel.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 26.10.2021.
//

import Combine

final class HomeViewModel: ObservableObject {
    let openSubscriptions = PassthroughSubject<Void, Never>()

    private let excuseService: ExcuseServiceType

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

    init(excuseService: ExcuseServiceType) {
        self.excuseService = excuseService
    }

    func setupActions() {
//        giveExcuseTapped = bindings.giveExcuseTap
//            .map { dependency.excuseService.getRandomExcuse() }
//            .eraseToAnyPublisher()
//        createOwnExcuseTapped = bindings.createOwnExcuseTap
//        subscriptionsTapped = bindings.subscriptionsTap
    }
}
