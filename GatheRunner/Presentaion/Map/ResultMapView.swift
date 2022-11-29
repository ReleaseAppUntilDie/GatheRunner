//
//  ResultMap.swift
//  GatheRunner
//
//  Created by hanJaeseung on 2022/11/13.
//

import SwiftUI
import MapKit

struct ResultMapView: View {
    @ObservedObject var manager: LocationManager
    
    var body: some View {
        MapWithPolyline(
            region: manager.resultMapRegion,
            lineCoordinates: $manager.polylineData,
            startPosition: $manager.startPosition,
            endPosition: $manager.endPosition
        )
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal, 30)
            
    }
}

struct ResultMap_Previews: PreviewProvider {
    static var previews: some View {
        ResultMapView(manager: LocationManager())
    }
}
