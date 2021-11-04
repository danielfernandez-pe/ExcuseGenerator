//
//  Test2ViewController.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 24.10.2021.
//

import UIKit
import Combine
import SwiftUI

final class Test2ViewController: UIHostingController<Test2View>, ViewModelAttaching {
    var viewModel: Test2ViewModel!
    var bindings: Test2ViewModel.Bindings {
        Test2ViewModel.Bindings(
            popTap: rootView.popTap.eraseToAnyPublisher(),
            finishTap: rootView.finishTap.eraseToAnyPublisher()
        )
    }

    func setupUI() {
        navigationItem.title = "Test2 Example"
    }
}

// MARK: - Create

extension Test2ViewController {
    static func create() -> Test2ViewController {
        Test2ViewController(
            rootView: Test2View()
        )
    }
}
