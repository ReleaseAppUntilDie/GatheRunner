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

    var body: some View {
        ZStack {
            mapView
            VStack {
                RunGuideTabView(selectedRunGuideTabItem: $selectedRunGuideTabItem)
                Spacer()
                BottomButtonsView()
            }
        }
    }

    var mapView: some View {
        Map(coordinateRegion: $manager.region, showsUserLocation: true).disabled(true)
    }
}

// MARK: - RunGuideTabView

struct RunGuideTabView: View {
    @Binding var selectedRunGuideTabItem: Int
    private let timer = Timer.publish(every: 5.5, on: .main, in: .default).autoconnect()
    var runningGuideArrs = RunGuideExperienceVM().getArrsRunGuideExperienceItem
    private let tabViewFrameWidthRatio: Double = 1
    private let tabViewFrameHeightRatio = 0.2
    private let forMapRadialGradient =
        Gradient(colors: [Color.white.opacity(0), Color.white, Color.white, Color.white, Color.white, Color.white.opacity(1)])

    var body: some View {
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
                timer.upstream.connect().cancel()
            }
            .highPriorityGesture(
                DragGesture()
                    .onChanged { _ in
                        timer.upstream.connect().cancel()
                    })
            .onReceive(timer) { _ in
                if runningGuideArrs.count - 1 >= selectedRunGuideTabItem + 1 {
                    selectedRunGuideTabItem += 1
                } else {
                    timer.upstream.connect().cancel()
                }
            }.animation(.default, value: selectedRunGuideTabItem)

            HStack(spacing: 5) {
                ForEach(runningGuideArrs.indices, id: \.self) { index in
                    Capsule()
                        .fill(Color.black.opacity(selectedRunGuideTabItem == index ? 1 : 0.55))
                        .frame(width: selectedRunGuideTabItem == index ? 18 : 6, height: 4)
                        .animation(.easeInOut, value: selectedRunGuideTabItem)
                }
            }
        }
    }
}

// MARK: - JustStartView_Previews

struct JustStartView_Previews: PreviewProvider {
    static var previews: some View {
        JustStartView(selectedRunGuideTabItem: .constant(0))
    }
}
