//
//  ChooseEndingViewController.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 29.10.2021.
//  
//

import UIKit
import Combine
import SwiftUI

final class ChooseEndingViewController: ControllerWithViewData<ChooseEndingView, ChooseEndingView.ViewData>, ViewModelAttaching {
    var viewModel: ChooseEndingViewModel!
    var bindings: ChooseEndingViewModel.Bindings {
        ChooseEndingViewModel.Bindings(
            buttonTap: rootView.buttonTap.eraseToAnyPublisher()
        )
    }

    private var cancellables = Set<AnyCancellable>()

    func setupUI() {
        navigationItem.title = L.endingTitle()
    }

    func setupBindings(viewModel: ChooseEndingViewModel) {
        viewModel.state
            .assign(to: \.state, on: viewData)
            .store(in: &cancellables)
    }
}
