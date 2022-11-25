import Combine
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion()
    @Published var currentLocation = CLLocationCoordinate2D()
    
    private var locationCancellable: Cancellable?
    private let manager = CLLocationManager()

    override init() {
        super.init()
        didsetLocationManager()
        bindLocation()
    }
}

// MARK: CLLocationManager

extension LocationManager {
    func didsetLocationManager() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            let center = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
            region = MKCoordinateRegion(center: center, span: span)
        }
    }
}

extension LocationManager {
    func bind() {
        locationCancellable = $region
            .sink { [weak self] in
                guard let self = self else { return }
                self.currentLocation = $0.center
            }
    }
    
    func cancleBinding() {
        locationCancellable?.cancel()
    }
    
    func resetLocation() {
        currentLocation = CLLocationCoordinate2D()
    }
    
    func startUpdate() {
        manager.startUpdatingLocation()
    }
    
    func stopUpdate() {
        manager.stopUpdatingLocation()
    }
}
