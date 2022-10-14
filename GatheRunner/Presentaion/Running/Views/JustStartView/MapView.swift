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
    @StateObject private var manager = LocationManager()

    var body: some View {
        Map(coordinateRegion: $manager.region, showsUserLocation: true).disabled(true)
    }
}

// MARK: - MapView_Previews

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
