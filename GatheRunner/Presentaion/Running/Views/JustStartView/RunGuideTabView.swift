//
//  RunGuideTabView.swift
//  GatheRunner
//
//  Created by cho on 2022/10/13.
//

import SwiftUI

// MARK: - RunGuideTabView

struct RunGuideTabView: View {
    @State private var selectedRunGuideTabItem: RunGuideItem? = nil
    @State private var selectedRunGuideTabItemNumber = 0
    @Binding var isPresentedRunGuideDetailDescriptionView: Bool
    private let timer = Timer.publish(every: 5.5, on: .main, in: .default).autoconnect()
    let runGuideExperienceItemArrs: [RunGuideItem] = RunGuideViewModel().getArrsRunGuideExperienceItem

    var body: some View {
        VStack {
            tabView
            HStack(spacing: 5) {
                tabViewIndicator
            }.padding(.top, 10)
        }
    }
}

extension RunGuideTabView {
    var tabView: some View {
        TabView(selection: $selectedRunGuideTabItemNumber) {
            RunGuideExperienceTabItem()
        }
        .frame(width: 330, height: 100)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .shadow(radius: 2)
        .onTapGesture {
            onTapGestureEvent()
        }
        .fullScreenCover(item: $selectedRunGuideTabItem, onDismiss: didDismiss) { item in
            RunGuideDetailDescriptionView(selectedItem: $selectedRunGuideTabItem, item: item)
                .onAppear {
                    isPresentedRunGuideDetailDescriptionView = true
                }
        }
        .highPriorityGesture(
            DragGesture()
                .onChanged { _ in
                    cancelTimerUpstreamConnect()
                })
        .onReceive(timer) { _ in
            dragGestureOnReceiveAction()
        }
        .animation(.default, value: selectedRunGuideTabItemNumber)
    }

    var tabViewIndicator: some View {
        ForEach(runGuideExperienceItemArrs.indices, id: \.self) { index in
            Capsule()
                .fill(Color.black.opacity(selectedRunGuideTabItemNumber == index ? 1 : 0.55))
                .frame(width: selectedRunGuideTabItemNumber == index ? 18 : 6, height: 4)
                .animation(.easeInOut, value: selectedRunGuideTabItemNumber)
        }
    }
}

extension RunGuideTabView {
    private func onTapGestureEvent() {
        cancelTimerUpstreamConnect()
        selectedRunGuideTabItem = runGuideExperienceItemArrs[selectedRunGuideTabItemNumber]
    }

    private func dragGestureOnReceiveAction() {
        if runGuideExperienceItemArrs.count - 1 >= selectedRunGuideTabItemNumber + 1 {
            selectedRunGuideTabItemNumber += 1
        } else {
            cancelTimerUpstreamConnect()
        }
    }

    private func cancelTimerUpstreamConnect() {
        timer.upstream.connect().cancel()
    }

    private func didDismiss() {
        isPresentedRunGuideDetailDescriptionView = false
    }
}

extension RunGuideTabView {
    private enum Size {
        static let tabViewFrameWidthRatio = 1.0
        static let tabViewFrameHeightRatio = 0.2
    }
}
