import Combine
import Foundation
import MapKit
import SwiftUI

// MARK: - LocationManager
// MARK: - 예외처리 구현 필요

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    // MARK: Lifecycle

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        setupSubscriptions()
    }

    // MARK: Internal

    @Published var region = MKCoordinateRegion()
    @Published var startLocation: CLLocation?
    @Published var distance = CLLocationDistance()
    @Published var currentPace = Double()
    @Published var minutes = "00"
    @Published var seconds = "00"

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            let center = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
            region = MKCoordinateRegion(center: center, span: span)
        }
    }

    func didSetStartLocation() {
        startLocation = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            self.progressTime += 1
            self.minutes = self.progressTime.minutes
            self.seconds = self.progressTime.seconds
        })
    }

    func didUnSetStartLocation() {
        startLocation = nil
        timer?.invalidate()
    }

    func setupSubscriptions() {
        $region.sink { [weak self] in
            guard let self = self, let startLocation = self.startLocation else { return }
            let to = CLLocation(latitude: $0.center.latitude, longitude: $0.center.longitude)

            if startLocation.distance(from: to) / 1000 > self.distance / 1000 {
                self.currentPace = Double(startLocation.distance(from: to)) / Double(self.progressTime)
            }
            self.distance = startLocation.distance(from: to)
        }
        .store(in: &disposables)
    }

    // MARK: Private

    private let manager = CLLocationManager()
    private var disposables = Set<AnyCancellable>()
    private var timer: Timer?
    private var progressTime = 0
}