//
//  RunGuideTabView.swift
//  GatheRunner
//
//  Created by cho on 2022/10/13.
//

import SwiftUI

struct RunGuideTabView: View {
    @State var selectedRunGuideTabItem: RunGuideItem? = nil
    @State var selectedRunGuideTabItemNumber: Int = 0
    @State var isPresented: Bool
    let runGuideExperienceItemArrs: [RunGuideItem] = RunGuideViewModel().getArrsRunGuideExperienceItem
    let timer = Timer.publish(every: 5.5, on: .main, in: .default).autoconnect()
    
    var body: some View {
        VStack {
            TabView(selection: $selectedRunGuideTabItemNumber) {
                RunGuideExperienceTabItem()
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(
                width: UIScreen.getWidthby(ratio: Size.tabViewFrameWidthRatio),
                height: UIScreen.getHeightby(ratio: Size.tabViewFrameHeightRatio))
            .shadow(radius: 2)
            .padding(-15)
            .onTapGesture {
                onTapGstureEvent()
            }
            .fullScreenCover(item: $selectedRunGuideTabItem, onDismiss: didDismiss) { item in
                FullScreenCoverView(item: item)
                    .onAppear {
                        isPresented = false
                    }
            }
            .highPriorityGesture(
                DragGesture()
                    .onChanged { _ in
                        cancelTimerConnect()
                    })
            .onReceive(timer) { _ in
                dragGestureOnReceiveEvent()
            }.animation(.default, value: selectedRunGuideTabItemNumber)
            HStack(spacing: 5) {
                ForEach(runGuideExperienceItemArrs.indices, id: \.self) { index in
                    Capsule()
                        .fill(Color.black.opacity(selectedRunGuideTabItemNumber == index ? 1 : 0.55))
                        .frame(width: selectedRunGuideTabItemNumber == index ? 18 : 6, height: 4)
                        .animation(.easeInOut, value: selectedRunGuideTabItemNumber)
                }
            }
        }
    }
}

extension RunGuideTabView {
    private enum Size {
        static let tabViewFrameWidthRatio: Double = 1
        static let tabViewFrameHeightRatio: Double = 0.2
    }
}

extension RunGuideTabView {
    private func onTapGstureEvent() {
        cancelTimerConnect()
        selectedRunGuideTabItem = runGuideExperienceItemArrs[selectedRunGuideTabItemNumber]
    }
    
    private func dragGestureOnReceiveEvent() {
        if runGuideExperienceItemArrs.count - 1 >= selectedRunGuideTabItemNumber + 1 {
            selectedRunGuideTabItemNumber += 1
        } else {
            cancelTimerConnect()
        }
    }
    
    private func cancelTimerConnect() {
        timer.upstream.connect().cancel()
    }
    
    private func didDismiss() {
        isPresented = true
    }
}
