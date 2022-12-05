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

// MARK: NameSpace

extension PrepareRunViewModel {
    private enum Content {
        static let sunnyEmoji = " ☀️☀️ "
        static let rainyEmoji = " ☁️☁️ "
        static let gradeComment = "오늘의 운동 지수 : "
        static let standard = "70"
        static let comma = ","
    }
    
    private enum Index {
        static let city = 0
        static let grade = 0
        static let comment = 1
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
        
        // MARK: Temp CityIndex
        
        let results = workoutIndex.outdoorGrade
        let content = results[Index.city].components(separatedBy: Content.comma)
        
        let grade = Content.gradeComment
        + content[Index.grade]
        + (content[Index.grade] >= Content.standard ? Content.sunnyEmoji : Content.rainyEmoji)
        
        let coment = content[Index.comment]
        
        return grade + coment
    }
}
