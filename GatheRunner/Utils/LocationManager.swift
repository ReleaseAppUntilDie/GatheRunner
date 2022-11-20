import Combine
import Foundation
import MapKit
import SwiftUI

// MARK: - LocationManager
// MARK: - 예외처리 구현 필요

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    enum RecordState {
        case start
        case pause
        case stopped
    }

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
    @Published var resultMapRegion = MKCoordinateRegion()
    @Published var distance = CLLocationDistance()
    @Published var currentPace = Double()
    @Published var minutes = "00"
    @Published var seconds = "00"
    @Published var polylineData = [CLLocationCoordinate2D]()
    @Published var endPosition: CLLocationCoordinate2D?
    @Published var startPosition: CLLocationCoordinate2D?
    
    var oldLocation = CLLocationCoordinate2D()

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            let center = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
            self.oldLocation = region.center
            polylineData.append(center)
            region = MKCoordinateRegion(center: center, span: span)
            
        }
    }

    func didSetStartLocation() {
        resultMapRegion = region
        
        recordState = .start
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            self.progressTime += 1
            self.minutes = self.progressTime.minutes
            self.seconds = self.progressTime.seconds
        })
    }

    func didUnSetStartLocation() {
        if recordState == .start {
            recordState = .pause
        }
        timer?.invalidate()
        resultMapRegion.center = region.center
    }
    
    func didStopRecording() {
        recordState = .stopped
        self.endPosition = self.region.center
        timer?.invalidate()
        
    }

    func setupSubscriptions() {
        $region.sink { [weak self] in
            guard let self = self, self.recordState == .start else { return }
            let to = CLLocation(latitude: $0.center.latitude, longitude: $0.center.longitude)
            self.currentPace = (Double(self.progressTime) / 60.0) / self.distance
            self.distance += CLLocation(latitude: self.oldLocation.latitude, longitude: self.oldLocation.longitude).distance(from: to) / 1000.0
        }
        .store(in: &disposables)
    }
    
    func publishedDataInit() {
        self.startPosition = nil
        self.endPosition = nil
        self.polylineData.removeAll()
        self.progressTime = 0
        self.minutes = "00"
        self.seconds = "00"
        self.currentPace = 0
        self.distance = 0
    }

    // MARK: Private

    private let manager = CLLocationManager()
    private var disposables = Set<AnyCancellable>()
    private var timer: Timer?
    private var recordState: RecordState = .stopped {
        didSet {
            if oldValue == .stopped && recordState == .start {
                self.publishedDataInit()
                self.startPosition = region.center
                
            }
        }
    }
    private var progressTime = 0
}
