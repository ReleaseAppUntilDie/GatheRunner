//
//  RunningView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/06/29.
//

import SwiftUI

struct RunningView: View {
    var body: some View {
        ZStack {
            Text("Running View")
            RunSplashScreen()
        }
    }
    
}

struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView()
    }
}
