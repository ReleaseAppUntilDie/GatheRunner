//
//  MapView.swift
//  GatheRunner
//
//  Created by cho on 2022/10/13.
//

import MapKit
import SwiftUI

// MARK: - MapView

struct MapView: View {
    @StateObject var viewModel: MapViewModel

    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true).disabled(true)
            .overlay(mapOverlayMask)
    }
}

extension MapView {
    private var mapOverlayMask: some View {
        Circle()
            .frame(width: 900, height: 1000, alignment: .center)
            .foregroundColor(Color.white)
            .mask {
                RadialGradient(gradient: Preset.radialGradientForMap, center: .center, startRadius: 100, endRadius: 600)
            }
    }
}

extension MapView {
    private enum Preset {
        static let radialGradientForMap: Gradient = Gradient(colors: [Color.white.opacity(0), Color.white, Color.white, Color.white, Color.white, Color.white.opacity(1)])
    }
}

// MARK: - MapView_Previews

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: DependencyContainer.previewMapScene)
    }
}
