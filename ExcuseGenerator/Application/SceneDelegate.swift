//
//  SceneDelegate.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 23.10.2021.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator!
    private var cancellables = Set<AnyCancellable>()
    var currentScene: UIWindowScene?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        currentScene = scene
        window = UIWindow(windowScene: scene)
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator.start()
            .sink(receiveValue: {})
            .store(in: &cancellables)
    }
}
