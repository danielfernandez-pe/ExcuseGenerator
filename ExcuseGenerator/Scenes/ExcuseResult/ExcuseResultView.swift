//
//  ExcuseResultView.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 29.10.2021.
//  
//

import SwiftUI
import Combine

struct ExcuseResultView: View {
    class ViewData: ObservableObject {
        @Published var excuse = ""
    }

    @ObservedObject var viewData: ViewData
    let homeTap = PassthroughSubject<Void, Never>()
    let shareTap = PassthroughSubject<Void, Never>()

    var body: some View {
        ZStack {
            Image(R.image.shapesResult.name)
                .resizable()
                .ignoresSafeArea()
            Text(viewData.excuse)
                .textStyle(.text1)
                .foregroundColor(Color(R.color.black.name))
                .padding(.horizontal, 64)
                .offset(y: -45)
        }
        .overlay(
            VStack {
                Spacer()
                HStack(spacing: 45) {
                    Button(action: { homeTap.send(()) }, label: {
                        Image(R.image.icHouse.name)
                            .frame(size: .init(width: 48, height: 48))
                            .background(Color(R.color.yellow.name))
                            .cornerRadius(Appearance.UIProperties.normalCornerRadius)
                    })
                    .buttonStyle(ScaleButtonStyle())

                    Button(action: { shareTap.send(()) }, label: {
                        Image(R.image.icShare.name)
                            .frame(size: .init(width: 48, height: 48))
                            .background(Color(R.color.green.name))
                            .cornerRadius(Appearance.UIProperties.normalCornerRadius)
                    })
                    .buttonStyle(ScaleButtonStyle())
                }
            }
            .padding(.bottom, 100)
        )
        .background(
            Color(R.color.white.name)
                .ignoresSafeArea()
        )
    }
}

struct ExcuseResultView_Previews: PreviewProvider {
    static var previews: some View {
        ExcuseResultView(viewData: .init())
    }
}
