//
//  RunningGuideView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI

// MARK: - RunningGuideView

struct RunningGuideView: View {
    
    // MARK: Internal
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            CardView()
        }
    }
}

// MARK: - RunningGuideView_Previews

struct RunningGuideView_Previews: PreviewProvider {
    static var previews: some View {
        RunningGuideView()
    }
}
