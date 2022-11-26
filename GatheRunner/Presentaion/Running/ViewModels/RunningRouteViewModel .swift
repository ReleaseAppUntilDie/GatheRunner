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
    
    private let locationManager: LocationManager
    private var cancelBag = Set<AnyCancellable>()
    private var locationCancellable: Cancellable?
    private var regionCancellable: Cancellable?

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
    }
        
    func startRecord() {
        locationCancellable = locationManager.regionSubject
            .sink { [weak self] region in
                guard let self = self else { return }
                self.region = region
                self.coordinates.append(region.center)
            }
    }
    
    func pauseRecord() {
        locationCancellable?.cancel()
    }
    
    func stopRecord() {
        locationCancellable?.cancel()
        coordinates = [CLLocationCoordinate2D]()
    }
}
