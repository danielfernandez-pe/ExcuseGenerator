//
//  LoadingViewController.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 29.10.2021.
//  
//

import UIKit
import Combine
import SwiftUI

final class LoadingViewController: ControllerWithViewData<LoadingView, LoadingView.ViewData>, ViewModelAttaching {
    var viewModel: LoadingViewModel!
    var bindings: LoadingViewModel.Bindings {
        LoadingViewModel.Bindings(
        )
    }

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
