//
//  SubscriptionsViewController.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 09.07.2022.
//

import UIKit
import Combine
import SwiftUI

final class SubscriptionsViewController: ControllerWithViewData<SubscriptionsView, SubscriptionsView.ViewData>, ViewModelAttaching {
    var viewModel: SubscriptionsViewModel!
    var bindings: SubscriptionsViewModel.Bindings {
        SubscriptionsViewModel.Bindings(
            closeTap: rootView.closeTap.eraseToAnyPublisher()
        )
    }

    private var cancellables = Set<AnyCancellable>()

    func setupBindings(viewModel: SubscriptionsViewModel) {
        viewModel.fetchedProducts
            .assign(to: \.products, on: viewData)
            .store(in: &cancellables)
    }
}
