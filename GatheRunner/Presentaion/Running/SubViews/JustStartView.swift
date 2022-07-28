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
    
    var body: some View {
        ZStack {
            mapView
            
            VStack {
                featured
                Spacer()
                FloatingView()
            }
            .frame(alignment: .center)
        }
    }
    
    var mapView: some View {
        Map(coordinateRegion: $manager.region, showsUserLocation: true).disabled(true)
            .overlay(
                Circle()
                    .frame(width: 900, height: 1000, alignment: .center)
                    .foregroundColor(Color.white)
                    .mask {
                        RadialGradient(gradient: Gradient(colors: [Color.white.opacity(0), Color.white, Color.white, Color.white, Color.white,     Color.white.opacity(1)]), center: .center, startRadius: 100, endRadius: 600)
                    }
            )
        
    }
    
    var featured: some View {
        TabView { RunningGuideItem() }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: 400, height: 120)
        .shadow(radius: 2)
    }
}

struct JustStartView_Previews: PreviewProvider {
    static var previews: some View {
        JustStartView()
    }
}
