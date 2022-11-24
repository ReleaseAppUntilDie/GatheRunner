//
//  RunGuideView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI

// MARK: - RunGuideView

struct RunGuideView: View {

    // MARK: Internal

    var body: some View {
        ScrollView(showsIndicators: false) {
            CardView()
        }
    }
}

// MARK: - RunGuideView_Previews

struct RunGuideView_Previews: PreviewProvider {
    static var previews: some View {
        RunGuideView()
    }
}
