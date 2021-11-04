//
//  HomeViewController.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 23.10.2021.
//

import UIKit
import Combine
import SwiftUI

final class Home2ViewController: UIHostingController<Home2View>, ViewModelAttaching {
    var viewModel: Home2ViewModel!
    var bindings: Home2ViewModel.Bindings {
        Home2ViewModel.Bindings(
            modalNavigationTap: rootView.modalNavigationTap.eraseToAnyPublisher(),
            modalTap: rootView.modalTap.eraseToAnyPublisher(),
            navigationTap: rootView.navigationTap.eraseToAnyPublisher()
        )
    }
}

// MARK: - Create

extension Home2ViewController {
    static func create() -> Home2ViewController {
        Home2ViewController(
            rootView: Home2View()
        )
    }
}
