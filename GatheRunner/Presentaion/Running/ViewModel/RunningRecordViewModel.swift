//
//  RunningRecordViewModel.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/24.
//

import Combine
import MapKit

class RunningRecordViewModel: ObservableObject {
    
    // MARK: Internal

    @Published var minutes = Content.defaultTime
    @Published var seconds = Content.defaultTime
    @Published var totalTravelDistance = Double()
    @Published var currentPace = Double()
    @Published var fetchStatus: FetchStatus = .none

    var cancelBag = Set<AnyCancellable>()
    var errorMessage = ""
    
    // MARK: Private
    
    private let runningRecordRepository: RunningRecordRepository
    private let locationManager: LocationManager
    private let timerManager: TimerManager
    private let userManager: UserManager
    
    private let fetchStatusSubject = CurrentValueSubject<FetchStatus, Never>(.none)
    
    private var locationCancellable: Cancellable?
    private var oldLocation: CLLocationCoordinate2D?
    private var oldTime = Int()
    
    // MARK: LifeCycle

    init(runningRecordRepository: RunningRecordRepository,
         locationManager: LocationManager,
         timerManager: TimerManager,
         userManager: UserManager) {
        self.runningRecordRepository = runningRecordRepository
        self.locationManager = locationManager
        self.timerManager = timerManager
        self.userManager = userManager
        
        bindFetchStatus()
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
                let travelDistance = self.calcDistance(with: location)
                
                self.updateRecord(on: location, calcWith: travelDistance)
            }
    }
    
    private func bindFetchStatus() {
        fetchStatusSubject.assign(to: \.fetchStatus, on: self)
            .store(in: &cancelBag)
    }
}

// MARK: Private NetworkTask

extension RunningRecordViewModel {
    private func uploadRecord() {
        fetchStatusSubject.send(.fetching)

        runningRecordRepository.post(runningRecordDTO)
            .sink { [weak self] completion in
                guard let self = self else { return }

                switch completion {
                case .failure(let error):
                    self.fetchStatusSubject.send(.failure)
                    self.errorMessage = error.localizedDescription

                default: return
                }
                
            } receiveValue: { [weak self] _ in
                self?.fetchStatusSubject.send(.success)
            }
            .store(in: &cancelBag)
    }
    
    private var runningRecordDTO: RunningRecord {
        return RunningRecord(uid: userManager.uid,
                             distance: String(format: Calc.distanceCeil, totalTravelDistance),
                             averagePace: calcAveragePace,
                             runningTime: (minutes + Content.colon + seconds),
                             date: Date.currentDate)
    }
}

// MARK: Private CalcTask

extension RunningRecordViewModel {
    private func calcDistance(with current: CLLocationCoordinate2D) -> Double {
        guard let oldLocation = oldLocation else {
            return Calc.resultZero
        }
        
        let oldCLLocation = CLLocation(latitude: oldLocation.latitude, longitude: oldLocation.longitude)
        let currentCLLocation = CLLocation(latitude: current.latitude, longitude: current.longitude)
        return oldCLLocation.distance(from: currentCLLocation) / Calc.distanceDivide
    }
    
    private var calcTime: Int {
        guard timerManager.progressTime > Calc.defaultZero else {
            return Int(Calc.resultZero)
        }
        
        return timerManager.progressTime - oldTime
    }
    
    private func calcPace(with distance: Double) -> Double {
        guard oldLocation != nil else {
            return Calc.resultZero
        }
        
        let beforeCeil = (Double(calcTime) / Calc.paceDivide) / distance
        return Double(String(format: Calc.paceCeil, beforeCeil)) ?? Calc.resultZero
    }

    private var calcAveragePace: String {
        let doubleType = (Double(timerManager.progressTime) / Calc.paceDivide) / totalTravelDistance
        return String(format: Calc.paceCeil, doubleType).toRecordFormat
    }
}

// MARK: Private Update Property

extension RunningRecordViewModel {
    private func updateRecord(on location: CLLocationCoordinate2D, calcWith travelDistance: Double) {
        totalTravelDistance += travelDistance
        currentPace = calcPace(with: travelDistance)
        
        oldLocation = location
        oldTime = timerManager.progressTime
    }
    
    private func resetRecord() {
        minutes = Content.defaultTime
        seconds = Content.defaultTime
        oldLocation = nil
        totalTravelDistance = Double()
        currentPace = Double()
    }
}
