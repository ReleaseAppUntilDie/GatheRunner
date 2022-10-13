//
//  MapView.swift
//  GatheRunner
//
//  Created by cho on 2022/10/13.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var manager = LocationManager()
    
    var body: some View {
        Map(coordinateRegion: $manager.region, showsUserLocation: true).disabled(true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
