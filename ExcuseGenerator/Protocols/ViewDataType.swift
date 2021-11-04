//
//  ViewDataType.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 28.10.2021.
//

import SwiftUI

protocol ViewControllerDataType: ViewDataType {
    associatedtype RootView: View

    init(viewData: ViewData, rootView: RootView)
}

protocol ViewDataType {
    associatedtype ViewData: ObservableObject

    var viewData: ViewData { get set }
}
