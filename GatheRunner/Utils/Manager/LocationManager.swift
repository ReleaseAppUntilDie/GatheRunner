import Combine
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let regionSubject = PassthroughSubject<MKCoordinateRegion, Never>()
    
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        didsetLocationManager()
    }
}

// MARK: CLLocationManager

extension LocationManager {
    private func didsetLocationManager() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            let center = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
            regionSubject.send(MKCoordinateRegion(center: center, span: span))
        }
    }
}
