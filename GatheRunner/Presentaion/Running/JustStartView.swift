//
//  JustStartView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI
import MapKit

struct JustStartView: View {
    @StateObject private var manager = LocationManager()
    
    let gradient = RadialGradient(gradient: Gradient(stops: [
        .init(color: Color.clear, location: 0),
        .init(color: Color.white, location: 0.5)]),
        center: .center, startRadius: 150, endRadius: 300)

    var body: some View {
        ZStack {
            mapView

            VStack {
                viewScrollDetection
                
                Spacer()
                
                HStack {
                    FloatingView()
                }
            }.frame(alignment: .center)
        }
    }
    
    var mapView: some View {
        Map(coordinateRegion: $manager.region, showsUserLocation: true).disabled(true)
            .overlay(
                Circle()
                    .frame(width: 600, height: 1000, alignment: .center)
                    .foregroundColor(Color.white)
                    .mask {
                        RadialGradient(gradient: Gradient(colors: [Color.white.opacity(0), Color.white, Color.white, Color.white, Color.white,     Color.white.opacity(1)]), center: .center, startRadius: 100, endRadius: 600)
                    }
            )
    }
    
    var viewScrollDetection: some View {
        GeometryReader { geo in
            featured
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(width: 400, height: 120)
//                .border(Color.red, width: 2)
        }
    }
    
    var featured: some View {
        TabView {
            ForEach(runningGuide) { item in
                RunningGuideItem(runningGuideArrs: item)
            }
        }
    }
}

struct JustStartView_Previews: PreviewProvider {
    static var previews: some View {
        JustStartView()
    }
}
