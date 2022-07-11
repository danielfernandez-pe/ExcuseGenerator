//
//  HomeView.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 26.10.2021.
//

import SwiftUI
import Combine

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
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

                giveMeAnExcuseButton

                createOwnExcuseButton

                subscriptionsButton

                premiumContentButton

                removeLocalDataButton
            }
            .padding(Appearance.Padding.medium)
        }
        .background(
            Color(R.color.white.name)
                .ignoresSafeArea()
        )
        .navigationBarHidden(true)
    }

    private var giveMeAnExcuseButton: some View {
        Button(action: { giveExcuseTap.send() }, label: {
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
    }

    private var createOwnExcuseButton: some View {
        Button(action: { createOwnExcuseTap.send() }, label: {
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
    }

    private var subscriptionsButton: some View {
        Button(action: { viewModel.openSubscriptions.send() }, label: {
            Text("Subscriptions")
                .frame(maxWidth: . infinity, alignment: .leading)
                .textStyle(.headline)
                .foregroundColor(Color(R.color.alwaysWhite.name))
                .padding(Appearance.Padding.normal)
                .background(
                    RoundedRectangle(cornerRadius: Appearance.UIProperties.bigCornerRadius)
                        .fill(Color(R.color.purple.name))
                )
        })
        .frame(width: boxSize.width)
        .buttonStyle(ScaleButtonStyle())
    }

    private var premiumContentButton: some View {
        Button(action: { viewModel.openPremiumContent.send() }, label: {
            Text("Premium content")
                .frame(maxWidth: . infinity, alignment: .leading)
                .textStyle(.headline)
                .foregroundColor(Color(R.color.white.name))
                .padding(Appearance.Padding.normal)
                .background(
                    RoundedRectangle(cornerRadius: Appearance.UIProperties.bigCornerRadius)
                        .fill(Color(R.color.green.name))
                )
        })
        .frame(width: boxSize.width)
        .buttonStyle(ScaleButtonStyle())
        .disabled(!viewModel.isUserPremium)
        .opacity(viewModel.isUserPremium ? 1 : 0.5)
    }

    private var removeLocalDataButton: some View {
        Button(action: { viewModel.removeSubscriptions.send() }, label: {
            Text("Remove local data")
                .frame(maxWidth: . infinity, alignment: .leading)
                .textStyle(.headline)
                .foregroundColor(Color(R.color.black.name))
                .padding(Appearance.Padding.normal)
                .background(
                    RoundedRectangle(cornerRadius: Appearance.UIProperties.bigCornerRadius)
                        .fill(Color(R.color.yellow.name))
                )
        })
        .frame(width: boxSize.width)
        .buttonStyle(ScaleButtonStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            viewModel: .init(
                iapManager: IapManager(),
                excuseService: ExcuseService()
            )
        )
    }
}
