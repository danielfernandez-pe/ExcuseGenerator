//
//  ModalNavigationViewController.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 24.10.2021.
//

import UIKit
import Combine
import SwiftUI

final class ModalNavigationViewController: UIHostingController<ModalNavigationView>, ViewModelAttaching {
    var viewModel: ModalNavigationViewModel!
    var bindings: ModalNavigationViewModel.Bindings {
        ModalNavigationViewModel.Bindings(
            pushTap: rootView.pushTap.eraseToAnyPublisher(),
            closeTap: closeButton.tapPublisher().eraseToAnyPublisher()
        )
    }

    private let closeButton = UIBarButtonItem(image: R.image.icClose(), style: .done, target: nil, action: nil)

    func setupUI() {
        navigationItem.title = "Modal Navigation Example"
        navigationItem.leftBarButtonItem = closeButton
    }
}

// MARK: - Create

extension ModalNavigationViewController {
    static func create() -> ModalNavigationViewController {
        ModalNavigationViewController(
            rootView: ModalNavigationView()
        )
    }
}
