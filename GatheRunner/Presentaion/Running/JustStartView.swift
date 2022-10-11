//
//  JustStartView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import MapKit
import SwiftUI

// MARK: - JustStartView

struct JustStartView: View {
    @StateObject private var manager = LocationManager()
    @Binding var selectedRunGuideTabItem: Int
    @State var isPresented = true
    @State private var selectedCardItem: RunGuideItem? = nil
    private let timer = Timer.publish(every: 5.5, on: .main, in: .default).autoconnect()
    var runGuideExperienceItemArrs = RunGuideViewModel().getArrsRunGuideExperienceItem
    private let tabViewFrameWidthRatio: Double = 1
    private let tabViewFrameHeightRatio = 0.2

    var body: some View {
        ZStack {
            mapView.show(isVisible: isPresented)
            VStack {
                runGuideTabView
                Spacer()
                BottomButtonsView()
            }
        }
    }

    var mapView: some View {
        Map(coordinateRegion: $manager.region, showsUserLocation: true).disabled(true)
    }
}

extension JustStartView {

    // MARK: Internal

    var runGuideTabView: some View {
        VStack {
            TabView(selection: $selectedRunGuideTabItem) {
                RunGuideExperienceTabItem()
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(
                width: UIScreen.getWidthby(ratio: tabViewFrameWidthRatio),
                height: UIScreen.getHeightby(ratio: tabViewFrameHeightRatio))
            .shadow(radius: 2)
            .padding(-15)
            .onTapGesture {
                cancelTimerConnect()
                selectedCardItem = runGuideExperienceItemArrs[selectedRunGuideTabItem]
            }
            .fullScreenCover(item: $selectedCardItem, onDismiss: didDismiss) { item in
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
                if runGuideExperienceItemArrs.count - 1 >= selectedRunGuideTabItem + 1 {
                    selectedRunGuideTabItem += 1
                } else {
                    cancelTimerConnect()
                }
            }.animation(.default, value: selectedRunGuideTabItem)
            HStack(spacing: 5) {
                ForEach(runGuideExperienceItemArrs.indices, id: \.self) { index in
                    Capsule()
                        .fill(Color.black.opacity(selectedRunGuideTabItem == index ? 1 : 0.55))
                        .frame(width: selectedRunGuideTabItem == index ? 18 : 6, height: 4)
                        .animation(.easeInOut, value: selectedRunGuideTabItem)
                }
            }
        }
    }

    // MARK: Private


    private func cancelTimerConnect() {
        timer.upstream.connect().cancel()
    }

    private func didDismiss() {
        isPresented = true
    }
}

// MARK: - JustStartView_Previews

struct JustStartView_Previews: PreviewProvider {
    static var previews: some View {
        JustStartView(selectedRunGuideTabItem: .constant(0))
    }
}
