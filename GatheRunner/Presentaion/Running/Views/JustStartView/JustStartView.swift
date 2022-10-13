//
//  JustStartView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI

// MARK: - JustStartView

struct JustStartView: View {
    @StateObject private var manager = LocationManager()
    @State private var isPresented = true
    
    var body: some View {
        ZStack {
            MapView().hide(isPresented)
            VStack {
                RunGuideTabView(isPresented: isPresented)
                Spacer()
                BottomButtonsView()
            }
        }
    }
}

// MARK: - JustStartView_Previews

struct JustStartView_Previews: PreviewProvider {
    static var previews: some View {
        JustStartView()
    }
}
