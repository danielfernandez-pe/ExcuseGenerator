//
//  TestViewController.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 24.10.2021.
//

import UIKit
import Combine
import SwiftUI

final class TestViewController: UIHostingController<TestView>, ViewModelAttaching {
    var viewModel: TestViewModel!
    var bindings: TestViewModel.Bindings {
        TestViewModel.Bindings(
            pushTap: rootView.pushTap.eraseToAnyPublisher()
        )
    }

    func setupUI() {
        navigationItem.title = "Test2 Example"
    }
}

// MARK: - Create

extension TestViewController {
    static func create() -> TestViewController {
        TestViewController(
            rootView: TestView()
        )
    }
}
