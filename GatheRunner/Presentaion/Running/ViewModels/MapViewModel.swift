//
//  MapViewModel.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/24.
//

import Combine
import MapKit

class MapViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion()
    
    let locationManager: LocationManager
    var cancelBag = Set<AnyCancellable>()
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        bindRegion()
    }
    
    func bindRegion() {
        locationManager.$region
            .assign(to: \.region, on: self)
            .store(in: &cancelBag)
    }
}
