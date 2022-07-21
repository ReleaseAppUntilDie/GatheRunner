//
//  RunningGuideView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI

struct RunningGuideView: View {
    var body: some View {
        // MARK: 미구현 -> 구현 예정
        ZStack {
            Image("runningGuide")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }.zIndex(1)
    }
}

struct RunningGuideView_Previews: PreviewProvider {
    static var previews: some View {
        RunningGuideView()
    }
}
