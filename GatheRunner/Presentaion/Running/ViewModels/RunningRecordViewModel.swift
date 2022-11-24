//
//  RunningRecordViewModel.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/24.
//

import Combine
import MapKit

class RunningRecordViewModel: ObservableObject {
    @Published var minutes = "00"
    @Published var seconds = "00"
    @Published var distance = Double()
    @Published var currentPace = Double()
    
    private let runningRecordRepository: RunningRecordRepository
    private let locationManager: LocationManager
    private let timerManager: TimerManager
    private var oldLocatioin = CLLocationCoordinate2D()

    var cancelBag = Set<AnyCancellable>()
        
    init(runningRecordRepository: RunningRecordRepository,
         locationManager: LocationManager,
         timerManager: TimerManager) {
        self.runningRecordRepository = runningRecordRepository
        self.locationManager = locationManager
        self.timerManager = timerManager
        
    }
}

extension RunningRecordViewModel {
    func startRecord() {
        setStartLocation()
        bindTimer()
        bindLocation()
    }
    
    func pauseRecord() {
        locationManager.cancleLocationBind()
        timerManager.cancleTimer()
    }
    
    func stopRecord() {
        locationManager.cancleLocationBind()
        timerManager.cancleTimer()
        locationManager.resetLocation()
        timerManager.resetTime()
    }
}

// MARK: private

extension RunningRecordViewModel {
    private func setStartLocation() {
        guard locationManager.startLocation == nil else {
            return
        }
        locationManager.startLocation = locationManager.region.center
        oldLocatioin = locationManager.startLocation ?? CLLocationCoordinate2D()
    }
    
    private func bindTimer() {
        timerManager.bindTimer()
        
        timerManager.$progressTime
            .sink { [weak self] progressTime in
                guard let self = self else { return }
                self.minutes = progressTime.minutes
                self.seconds = progressTime.seconds
            }
            .store(in: &cancelBag)
    }
    
    private func bindLocation() {
        locationManager.$currentLocation
            .sink { [weak self] location in
                guard let self = self else { return }
                self.distance += self.calcDistance(current: location)
                self.currentPace = self.calcPace
                self.oldLocatioin = location
            }
            .store(in: &cancelBag)
    }
    
    private var calcPace: Double {
        (Double(timerManager.progressTime) / 60) / distance
    }
    
    private func calcDistance(current: CLLocationCoordinate2D) -> Double {
        let oldCLLocation = CLLocation(latitude: oldLocatioin.latitude, longitude: oldLocatioin.longitude)
        let currentCLLocation = CLLocation(latitude: current.latitude, longitude: current.longitude)
        return oldCLLocation.distance(from: currentCLLocation) / 1000
    }
}
