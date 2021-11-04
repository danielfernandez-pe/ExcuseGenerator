//
//  LoadingView.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 29.10.2021.
//  
//

import SwiftUI
import Combine

struct LoadingView: View, ViewDataType {
    class ViewData: ObservableObject {
    }

    @ObservedObject var viewData: ViewData
    @State private var startAnimation = false
    @State private var changeColor = false

    private let widthAndHeight: CGFloat = 150
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher> = {
        Timer.publish(every: 1.2, on: .main, in: .common).autoconnect()
    }()

    private var borderColor: Color {
        changeColor ? Color(R.color.green.name): Color(R.color.yellow.name)
    }

    var body: some View {
        ZStack {
            Color(R.color.loadingBackground.name)
                .ignoresSafeArea()

            Circle()
                .fill(borderColor)
                .frame(
                    width: startAnimation ? widthAndHeight : 50,
                    height: startAnimation ? widthAndHeight : 50
                )
            Circle()
                .fill(Color(R.color.loadingBackground.name))
                .frame(
                    width: startAnimation ? widthAndHeight : 0,
                    height: startAnimation ? widthAndHeight : 0
                )
        }
        .onReceive(timer) { _ in
            changeColor.toggle()
        }
        .onAppear {
            withAnimation(
                Animation
                    .easeOut(duration: 1.2)
                    .repeatForever(autoreverses: false)
            ) {
                self.startAnimation = true
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(viewData: .init())
    }
}
