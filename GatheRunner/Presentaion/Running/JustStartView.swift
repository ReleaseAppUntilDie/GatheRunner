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
    @Binding var selected: Int
    let timer = Timer.publish(every: 5.5, on: .main, in: .default).autoconnect()
    var runningGuideArrs = RunGuideExperienceItemVM().getArrsRunGuideExperienceItem
    let forMapRadialGradient =
        Gradient(colors: [Color.white.opacity(0), Color.white, Color.white, Color.white, Color.white, Color.white.opacity(1)])

    var body: some View {
        ZStack {
            mapView
            VStack {
                featuredTabView
                Spacer()
                FloatingView()
            }
        }
    }

    var mapView: some View {
        Map(coordinateRegion: $manager.region, showsUserLocation: true).disabled(true)
    }

    var featuredTabView: some View {
        VStack {
            TabView(selection: $selected) {
                RunGuideExperienceTabItem()
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.getHeightby(ratio: 0.2))
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
                if runningGuideArrs.count - 1 >= selected + 1 {
                    selected += 1
                } else {
                    timer.upstream.connect().cancel()
                }
            }.animation(.default, value: selected)

            HStack(spacing: 5) {
                ForEach(runningGuideArrs.indices, id: \.self) { index in
                    Capsule()
                        .fill(Color.black.opacity(selected == index ? 1 : 0.55))
                        .frame(width: selected == index ? 18 : 6, height: 4)
                        .animation(.easeInOut, value: selected)
                }
            }
        }
    }
}

// MARK: - JustStartView_Previews

struct JustStartView_Previews: PreviewProvider {
    static var previews: some View {
        JustStartView(selected: .constant(0))
    }
}
