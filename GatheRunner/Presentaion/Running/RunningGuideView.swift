//
//  RunningGuideView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI

// MARK: - RunningGuideView

struct RunningGuideView: View {
    var body: some View {
        // MARK: 미구현 -> 구현 예정
        ZStack {
            VStack {
                Image("runningGuide")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
        }.zIndex(1)
    }
}

// MARK: - RunningGuideView_Previews

struct RunningGuideView_Previews: PreviewProvider {
    static var previews: some View {
        RunningGuideView()
    }
}
