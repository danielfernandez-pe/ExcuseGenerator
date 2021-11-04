//
//  ExcuseResultViewController.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 29.10.2021.
//  
//

import UIKit
import Combine
import SwiftUI

final class ExcuseResultViewController: ControllerWithViewData<ExcuseResultView, ExcuseResultView.ViewData>, ViewModelAttaching {
    var viewModel: ExcuseResultViewModel!
    var bindings: ExcuseResultViewModel.Bindings {
        ExcuseResultViewModel.Bindings(
            homeTap: rootView.homeTap.eraseToAnyPublisher()
        )
    }

    private var cancellables = Set<AnyCancellable>()

    func setupBindings(viewModel: ExcuseResultViewModel) {
        rootView.shareTap
            .sink { [weak self] _ in
                let ac = UIActivityViewController(activityItems: [viewModel.excuse.value], applicationActivities: nil)
                self?.present(ac, animated: true)
            }
            .store(in: &cancellables)

        viewModel.excuse
            .assign(to: \.excuse, on: viewData)
            .store(in: &cancellables)
    }
}
