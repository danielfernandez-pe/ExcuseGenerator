//
//  ChooseMediumViewController.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 29.10.2021.
//  
//

import UIKit
import Combine
import SwiftUI

// final class ChooseMediumViewController: ControllerWithViewData<ChooseMediumView, ChooseMediumView.ViewData>, ViewModelAttaching {
//    var viewModel: ChooseMediumViewModel!
//    var bindings: ChooseMediumViewModel.Bindings {
//        ChooseMediumViewModel.Bindings(
//            buttonTap: rootView.buttonTap.eraseToAnyPublisher()
//        )
//    }
//
//    private var cancellables = Set<AnyCancellable>()
//
//    func setupUI() {
//        navigationItem.title = L.scapegoatTitle()
//    }
//
//    func setupBindings(viewModel: ChooseMediumViewModel) {
//        viewModel.state
//            .assign(to: \.state, on: viewData)
//            .store(in: &cancellables)
//    }
// }
