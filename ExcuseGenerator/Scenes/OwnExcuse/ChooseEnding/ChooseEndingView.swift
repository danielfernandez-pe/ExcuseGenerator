//
//  ChooseEndingView.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 29.10.2021.
//  
//

import SwiftUI
import Combine

struct ChooseEndingView: View, ViewDataType {
    class ViewData: ObservableObject {
        @Published var state: ChooseState = .loading
    }

    @ObservedObject var viewData: ViewData
    let buttonTap = PassthroughSubject<String, Never>()

    var body: some View {
        switch viewData.state {
        case .loading:
            Text("Loading")
        case .content(let intros):
            ScrollView {
                LazyVStack(spacing: Appearance.Padding.medium) {
                    ForEach(intros, id: \.self) { ending in
                        HighlightedButton(
                            text: ending,
                            textColor: Color(R.color.black.name),
                            textHighlightedColor: Color(R.color.alwaysWhite.name),
                            backgroundColor: Color(R.color.button.name),
                            backgroundHighlightedColor: Color(R.color.purple.name),
                            action: { buttonTap.send(ending) }
                        )
                    }
                }
                .padding(Appearance.Padding.normal)
            }
            .background(
                Color(R.color.white.name)
                    .ignoresSafeArea()
            )
        case .failure:
            Text("Failure")
        }
    }
}

struct ChooseEndingView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseEndingView(viewData: .init())
    }
}
