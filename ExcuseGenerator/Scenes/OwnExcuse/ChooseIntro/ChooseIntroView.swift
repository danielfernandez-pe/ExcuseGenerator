//
//  ChooseIntroView.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 26.10.2021.
//

import SwiftUI
import Combine

struct ChooseIntroView: View {
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
                    ForEach(intros, id: \.self) { intro in
                        HighlightedButton(
                            text: intro,
                            textColor: Color(R.color.black.name),
                            textHighlightedColor: Color(R.color.alwaysWhite.name),
                            backgroundColor: Color(R.color.button.name),
                            backgroundHighlightedColor: Color(R.color.salmon.name),
                            action: { buttonTap.send(intro) }
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

struct ChooseIntroView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseIntroView(viewData: .init())
    }
}
