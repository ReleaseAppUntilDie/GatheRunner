//
//  RunningRecordViewModel.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/24.
//

import Combine
import MapKit

class RunningRecordViewModel: ObservableObject {
    @Published var minutes = Content.defaultTime
    @Published var seconds = Content.defaultTime
    @Published var distance = Double()
    @Published var currentPace = Double()
    @Published var isFinished = false

    var cancelBag = Set<AnyCancellable>()
    
    // MARK: Private
    
    private let runningRecordRepository: RunningRecordRepository
    private let locationManager: LocationManager
    private let timerManager: TimerManager
    private let userManager: UserManager
    
    private var oldLocation: CLLocationCoordinate2D?
    private var locationCancellable: Cancellable?
    private var paceRecords = [Double]()
    
    init(runningRecordRepository: RunningRecordRepository,
         locationManager: LocationManager,
         timerManager: TimerManager,
         userManager: UserManager) {
        self.runningRecordRepository = runningRecordRepository
        self.locationManager = locationManager
        self.timerManager = timerManager
        self.userManager = userManager
    }
}

// MARK: NameSpace

extension RunningRecordViewModel {
    private enum Content {
        static let defaultTime = "00"
        static let colon = ":"
    }
    
    private enum Calc {
        static let defaultZero = 0
        static let resultZero: Double = 0
        static let paceDivide: Double = 60
        static let distanceDivide: Double = 1000
        static let distanceCeil = "%.1f"
        static let paceCeil = "%.2f"
    }
}

// MARK: Record LifeCycle

extension RunningRecordViewModel {
    func startRecord() {
        bindTimer()
        bindLocation()
        bindPace()
    }
    
    func pauseRecord() {
        timerManager.cancleBinding()
        locationCancellable?.cancel()
    }
    
    func stopRecord() {
        timerManager.cancleBinding()
        locationCancellable?.cancel()
        
        uploadRecord()
        
        timerManager.resetTime()
        resetRecord()
    }
}

// MARK: Private Bind

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
            }
    }
    
    private func bindPace() {
        $currentPace
            .sink { [weak self] in
                self?.paceRecords.append($0)
            }
            .store(in: &cancelBag)
    }
}

// MARK: Private Methods

extension RunningRecordViewModel {
    private func resetRecord() {
        minutes = Content.defaultTime
        seconds = Content.defaultTime
        oldLocation = nil
        distance = Double()
        currentPace = Double()
        paceRecords = [Double]()
    }
    
    private func uploadRecord() {
        runningRecordRepository.post(runningRecordDTO)
            .sink { completion in
                switch completion {
                case .failure(let error): print("error \(error)")
                default: print("completion \(completion)")
                }
                
            } receiveValue: { [weak self] _ in
                self?.isFinished = true
            }
            .store(in: &cancelBag)
    }
    
    private var runningRecordDTO: RunningRecord {
        return RunningRecord(uid: userManager.uid,
                             distance: String(format: Calc.distanceCeil, distance),
                             averagePace: averagePace,
                             runningTime: minutes + Content.colon + seconds,
                             date: Date.currentDate)
    }
}

// MARK: Private Calc

extension RunningRecordViewModel {
    private var calcPace: Double {
        guard timerManager.progressTime > Calc.defaultZero, oldLocation != nil else {
            return Calc.resultZero
        }
        
        let pace = (Double(timerManager.progressTime) / Calc.paceDivide) / distance
        
        return Double(String(format: Calc.paceCeil, pace)) ?? Calc.resultZero
    }
    
    private func calcDistance(current: CLLocationCoordinate2D) -> Double {
        guard let oldLocation = oldLocation else {
            return Calc.resultZero
        }
        
        let oldCLLocation = CLLocation(latitude: oldLocation.latitude, longitude: oldLocation.longitude)
        let currentCLLocation = CLLocation(latitude: current.latitude, longitude: current.longitude)
        return oldCLLocation.distance(from: currentCLLocation) / Calc.distanceDivide
    }
    
    private var averagePace: String {
        guard !paceRecords.isEmpty else {
            return String(Calc.resultZero)
        }
                
        return (paceRecords.reduce(0.0, +) / Double(paceRecords.count)).toRecordFormat
    }
}