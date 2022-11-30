import Combine
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private enum Option {
        static let span = 0.004
    }

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
            let span = MKCoordinateSpan(latitudeDelta: Option.span, longitudeDelta: Option.span)
            regionSubject.send(MKCoordinateRegion(center: center, span: span))
        }
    }
}
