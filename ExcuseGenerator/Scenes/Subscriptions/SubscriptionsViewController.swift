//
//  SubscriptionsViewController.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 09.07.2022.
//

import UIKit
import Combine
import SwiftUI

final class SubscriptionsViewController: UIHostingController<SubscriptionsView>, ViewModelAttaching {
    var viewModel: SubscriptionsViewModel!
    var bindings: SubscriptionsViewModel.Bindings {
        SubscriptionsViewModel.Bindings(
            giveExcuseTap: rootView.giveExcuseTap.eraseToAnyPublisher(),
            createOwnExcuseTap: rootView.createOwnExcuseTap.eraseToAnyPublisher()
        )
    }
}

// MARK: - Create

extension SubscriptionsViewController {
    static func create() -> SubscriptionsViewController {
        SubscriptionsViewController(
            rootView: SubscriptionsView()
        )
    }
}
