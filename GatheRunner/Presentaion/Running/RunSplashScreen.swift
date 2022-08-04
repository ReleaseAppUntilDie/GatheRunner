//
//  RunSplashScreen.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/07/07.
//

import SwiftUI

struct RunSplashScreen: View {
    private let initialTime: Int
    @State private var timeRemaining: Int = 3
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            countNumberText
        }
        .onAppear { timeRemaining = initialTime }
        .opacity(timeRemaining > 0 ? 1 : 0)
        
    }
}

extension RunSplashScreen {
    init(_ initialTime: Int = 3) {
        self.init(initialTime: initialTime)
    }
}

extension RunSplashScreen {
    var countNumberText: some View {
        Text("\(timeRemaining)")
            .asTimerStyle()
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                timeRemaining -= timeRemaining > 0 ? 1 : 0
            }
    }
    
}

struct RunSplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        RunSplashScreen()
    }
}
