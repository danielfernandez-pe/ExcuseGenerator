//
//  HomeViewController.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 26.10.2021.
//

import UIKit
import Combine
import SwiftUI

final class HomeViewController: UIHostingController<HomeView>, ViewModelAttaching {
    var viewModel: HomeViewModel!
    var bindings: HomeViewModel.Bindings {
        HomeViewModel.Bindings(
            giveExcuseTap: rootView.giveExcuseTap.eraseToAnyPublisher(),
            createOwnExcuseTap: rootView.createOwnExcuseTap.eraseToAnyPublisher()
        )
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

// MARK: - Create

extension HomeViewController {
    static func create() -> HomeViewController {
        HomeViewController(
            rootView: HomeView()
        )
    }
}
