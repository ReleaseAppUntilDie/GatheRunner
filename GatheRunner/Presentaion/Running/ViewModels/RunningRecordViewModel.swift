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
    private var oldLocation: CLLocationCoordinate2D?
    private var locationCancellable: Cancellable?
    
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
        bindTimer()
        bindLocation()
    }
    
    func pauseRecord() {
        timerManager.cancleBinding()
        locationCancellable?.cancel()
    }
    
    func stopRecord() {
        timerManager.cancleBinding()
        locationCancellable?.cancel()
        
        timerManager.resetTime()
        resetRecord()
    }
}

// MARK: private

extension RunningRecordViewModel {    
    private func bindTimer() {
        timerManager.bind()
        
        timerManager.$progressTime
            .sink { [weak self] progressTime in
                guard let self = self else { return }
                self.minutes = progressTime.minutes
                self.seconds = progressTime.seconds
            }
            .store(in: &cancelBag)
    }
    
    private func bindLocation() {
        locationCancellable = locationManager.regionSubject
            .sink { [weak self] region in
                guard let self = self else { return }
                
                let location = region.center
                self.distance += self.calcDistance(current: location)
                self.currentPace = self.calcPace
                self.oldLocation = location
                print("recordVm distance \(self.distance) currentPace \(self.currentPace)")
            }
        
//        locationCancellable = locationManager.$region
//                    .sink { [weak self] region in
//                        guard let self = self else { return }
//                        let location = region.center
//                        self.distance += self.calcDistance(current: location)
//                        self.currentPace = self.calcPace
//                        self.oldLocatioin = location
//                        print("recordVm distance \(self.distance) currentPace \(self.currentPace)")
//                    }
//                    .store(in: &cancelBag)

//        locationManager.$currentLocation
//            .sink { [weak self] location in
//                guard let self = self else { return }
//                self.distance += self.calcDistance(current: location)
//                self.currentPace = self.calcPace
//                self.oldLocatioin = location
////                print("bindLocation distance \(self.distance) currentPace \(self.currentPace)")
//            }
//            .store(in: &cancelBag)
    }
    
    private var calcPace: Double {
        guard timerManager.progressTime > 0, oldLocation != nil else {
            return 0
        }
        
        return (Double(timerManager.progressTime) / 60) / distance
    }
    
    private func calcDistance(current: CLLocationCoordinate2D) -> Double {
        guard let oldLocation = oldLocation else {
            return 0
        }
        
        let oldCLLocation = CLLocation(latitude: oldLocation.latitude, longitude: oldLocation.longitude)
        let currentCLLocation = CLLocation(latitude: current.latitude, longitude: current.longitude)
        return oldCLLocation.distance(from: currentCLLocation) / 1000
    }
    
    private func resetRecord() {
        minutes = "00"
        seconds = "00"
        oldLocation = nil
        distance = Double()
        currentPace = Double()
    }
}
