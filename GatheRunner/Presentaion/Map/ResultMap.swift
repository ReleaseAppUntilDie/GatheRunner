//
//  ResultMap.swift
//  GatheRunner
//
//  Created by hanJaeseung on 2022/11/13.
//

import SwiftUI
import MapKit

struct ResultMap: View {
    @ObservedObject var manager: LocationManager
    
    var body: some View {
        Map(coordinateRegion: $manager.resultMapRegion, showsUserLocation: false)
            .disabled(false)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal, 30)
            
    }
}

struct ResultMap_Previews: PreviewProvider {
    static var previews: some View {
        ResultMap(manager: LocationManager())
    }
}
