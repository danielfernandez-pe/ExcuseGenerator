//
//  ChooseIntroViewController.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 26.10.2021.
//

import UIKit
import Combine
import SwiftUI

// final class ChooseIntroViewController: ControllerWithViewData<ChooseIntroView, ChooseIntroView.ViewData>, ViewModelAttaching {
//    var viewModel: ChooseIntroViewModel!
//    var bindings: ChooseIntroViewModel.Bindings {
//        ChooseIntroViewModel.Bindings(
//            buttonTap: rootView.buttonTap.eraseToAnyPublisher()
//        )
//    }
//
//    private var cancellables = Set<AnyCancellable>()
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        navigationController?.setNavigationBarHidden(false, animated: false)
//    }
//
//    func setupUI() {
//        navigationItem.title = L.introTitle()
//    }
//
//    func setupBindings(viewModel: ChooseIntroViewModel) {
//        viewModel.state
//            .assign(to: \.state, on: viewData)
//            .store(in: &cancellables)
//    }
// }
