//
//  ControllerWithViewData.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 28.10.2021.
//

import SwiftUI

class ControllerWithViewData<RootView: View, ViewData: ObservableObject>: UIHostingController<RootView>, ViewControllerDataType {
    var viewData: ViewData

    required init(viewData: ViewData, rootView: RootView) {
        self.viewData = viewData
        super.init(rootView: rootView)
    }

    @MainActor @objc
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
