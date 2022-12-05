//
//  PrepareRunViewModel.swift
//  GatheRunner
//
//  Created by cho on 2022/11/22.
//

import Combine

class PrepareRunViewModel: ObservableObject {
    @Published var todayInfo = ""
    @Published var fetchStatus: FetchStatus = .none

    var errorMessage = ""

    // MARK: Private
    
    private let workoutIndexRepository: WorkoutIndexRepository
    private let fetchStatusSubject = CurrentValueSubject<FetchStatus, Never>(.none)
    
    private var cancelBag = Set<AnyCancellable>()

    // MARK: LifeCycle

    init(workoutIndexRepository: WorkoutIndexRepository) {
        self.workoutIndexRepository = workoutIndexRepository
        
        bindFetchStatus()
        fetchTodayInfo()
    }
}

// MARK: Private Methods

extension PrepareRunViewModel {
    private func bindFetchStatus() {
        fetchStatusSubject.assign(to: \.fetchStatus, on: self)
            .store(in: &cancelBag)
    }
    
    private func fetchTodayInfo() {
        fetchStatusSubject.send(.fetching)
        
        workoutIndexRepository.fetch(TodayWorkoutIndex())
            .sink { [weak self] completion in
                guard let self = self else { return }

                switch completion {
                case .failure(let error):
                    self.fetchStatusSubject.send(.failure)
                    self.errorMessage = error.localizedDescription
                    
                default: return
                }
                
            } receiveValue: { [weak self] result in
                guard let self = self else { return }
                
                self.fetchStatusSubject.send(.success)
                self.todayInfo = self.workoutIndexDTO(with: result)
            }
            .store(in: &cancelBag)
    }

    private func workoutIndexDTO(with workoutIndex: WorkoutIndex) -> String {
        
        // MARK: Temp City Info
        
        let results = workoutIndex.outdoorGrade
        let content = results[0].components(separatedBy: ",")
        let grade = "오늘의 운동 지수 : " + content[0] + (content[0] >= "70" ? " ☀️☀️ " : " ☁️☁️ ")
        let coment = content[1]

        return grade + coment
    }
}
