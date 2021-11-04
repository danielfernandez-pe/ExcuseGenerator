//
//  HomeView.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 26.10.2021.
//

import SwiftUI
import Combine

struct HomeView: View {
    let giveExcuseTap = PassthroughSubject<Void, Never>()
    let createOwnExcuseTap = PassthroughSubject<Void, Never>()

    private let boxSize = CGSize(width: 183, height: 120)

    var body: some View {
        ZStack {
            Image(R.image.shapes.name)
                .resizable()
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {
                ColoredText(
                    L.title(),
                    matching: L.titleColored(),
                    color: Color(R.color.homeTitle.name)
                )
                .textStyle(.title1)
                .lineLimit(3)
                .minimumScaleFactor(0.5)
                .padding(.top, 100)
                .padding(.trailing, 100)
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                Button(action: { giveExcuseTap.send(()) }, label: {
                    VStack(alignment: .leading) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color(R.color.alwaysWhite.name))
                            Spacer()
                        Text(L.giveMeExcuse())
                            .textStyle(.headline)
                            .foregroundColor(Color(R.color.alwaysWhite.name))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(Appearance.Padding.normal)
                    .background(
                        RoundedRectangle(cornerRadius: Appearance.UIProperties.bigCornerRadius)
                            .fill(Color(R.color.salmon.name))
                    )
                    .frame(size: boxSize)
                })
                .buttonStyle(ScaleButtonStyle())

                Button(action: { createOwnExcuseTap.send(()) }, label: {
                    VStack(alignment: .leading) {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color(R.color.alwaysWhite.name))
                            Spacer()
                        Text(L.createExcuse())
                            .textStyle(.headline)
                            .foregroundColor(Color(R.color.alwaysWhite.name))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(Appearance.Padding.normal)
                    .background(
                        RoundedRectangle(cornerRadius: Appearance.UIProperties.bigCornerRadius)
                            .fill(Color(R.color.green.name))
                    )
                    .frame(size: boxSize)
                })
                .buttonStyle(ScaleButtonStyle())
                .padding(.bottom, 50)
            }
            .padding(Appearance.Padding.medium)
        }
        .background(
            Color(R.color.white.name)
                .ignoresSafeArea()
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
