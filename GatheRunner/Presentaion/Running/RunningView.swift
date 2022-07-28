//
//  RunningView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI

struct RunningView: View {
    @State private var justStartButtonIsSelected: Bool = true
    @State private var runningGuideButtonIsSelected: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                
                //MARK: - Temporary Header
                
                Text("Header View")
                    .frame(width: UIScreen.main.bounds.size.width, height: 120)
                    .zIndex(1)
                
                HStack {
                    commonBtn(title: "바로 시작", isToggled: $justStartButtonIsSelected, isOtherToggled: $runningGuideButtonIsSelected).padding(4)
                    commonBtn(title: "러닝 가이드", isToggled: $runningGuideButtonIsSelected, isOtherToggled: $justStartButtonIsSelected)
                }
                .zIndex(1)
                .frame(width: 400, height: 30, alignment: .leading)
                
                if justStartButtonIsSelected {
                    JustStartView().transition(.move(edge: .leading))
                }
                
                if runningGuideButtonIsSelected {
                    RunningGuideView().transition(.move(edge: .trailing))
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea(edges: .top)
        }
        
    }
}

struct commonBtn: View {
    var title: String
    @Binding var isToggled: Bool
    @Binding var isOtherToggled: Bool
    
    var body: some View {
        Button(title) {
            withAnimation {
                if !isToggled {
                    self.isToggled.toggle()
                    self.isOtherToggled.toggle()
                }
            }
        }
        .frame(width: 100, height: 10)
        .foregroundColor(isToggled ? Color.black : Color.gray)
        .font(.system(size: 14))
        
    }
}

struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView()
    }
}
