//
//  RunningRouteViewModel .swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/24.
//

import Combine
import MapKit

class RunningRouteViewModel: ObservableObject {
    @Published var coordinates = [CLLocationCoordinate2D]()
    @Published var region = MKCoordinateRegion()
    @Published var currentLocation = CLLocationCoordinate2D()
    @Published var startLocatioin: CLLocationCoordinate2D?

    let locationManager: LocationManager
    
    var cancelBag = Set<AnyCancellable>()

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        bindLocation()
    }
    
    func bindLocation() {
        
        locationManager.$region
            .assign(to: \.region, on: self)
            .store(in: &cancelBag)
        
        locationManager.$currentLocation
            .assign(to: \.currentLocation, on: self)
            .store(in: &cancelBag)

        let startLocation = locationManager.startLocation ?? CLLocationCoordinate2D()
        self.startLocatioin = startLocation
        coordinates.append(startLocation)

        locationManager.$currentLocation
            .sink { [weak self] location in
                self?.coordinates.append(location)
            }
            .store(in: &cancelBag)
        
    }
}
