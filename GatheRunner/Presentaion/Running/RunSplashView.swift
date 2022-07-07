//
//  RunSplashView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/07/07.
//

import SwiftUI

struct RunSplashView: View {
    @State var timeRemaining = 3
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            countNumberText
        }
    }
}

extension RunSplashView {
    var countNumberText: some View {
        Text("\(timeRemaining)")
            .asTimerStyle()
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                timeRemaining -= timeRemaining > 0 ? 1 : 0
            }
        
    }
}

struct RunSplashView_Previews: PreviewProvider {
    static var previews: some View {
        RunSplashView()
    }
}
