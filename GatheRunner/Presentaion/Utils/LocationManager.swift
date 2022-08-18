import Foundation
import MapKit
import SwiftUI

// MARK: - LocationManager

// 에러 예외처리 필요 -> 구현 예정
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    // MARK: Lifecycle

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    // MARK: Internal

    @Published var region = MKCoordinateRegion()
    @Published var currentPace = Double()
    var startingPoint = MKCoordinateRegion()

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            currentPace = locations.last?.speed ?? 0
            let center = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
            region = MKCoordinateRegion(center: center, span: span)
        }
    }

    // MARK: Private

    private let manager = CLLocationManager()
}

extension LocationManager {

    var distance: CLLocationDistance {
        let from = CLLocation(latitude: startingPoint.center.latitude, longitude: startingPoint.center.longitude)
        let to = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
        return from.distance(from: to)
    }
}
