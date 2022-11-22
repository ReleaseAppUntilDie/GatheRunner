//
//  PrepareRunViewModel.swift
//  GatheRunner
//
//  Created by cho on 2022/11/22.
//

import Combine

class PrepareRunViewModel: ObservableObject {
    @Published var fetchedWorkoutIndexArrs: [String]?
    
    func getWorkoutIndex() {
        APIs.fetchWorkoutIndex()
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    print("fetch workoutIndex Error")
                default:
                    print("fetch workoutIndex Completion \(completion)")
                }
            } receiveValue: { result in
                self.fetchedWorkoutIndexArrs = result.outdoorGrade
            }.store(in: &APIs.cancelBag)
    }
    
    func getWorkoutIndexContents() -> String {
        guard let fetchedWorkoutIndexArrs = self.fetchedWorkoutIndexArrs else { return "" }
        
        let parsedContents = parseWorkoutIndexContents(fetchedWorkoutIndexArrs[0])
        
        if let convertIntToIndex = Int(parsedContents[0]) {
            return "오늘의 운동 지수 : " + parsedContents[0] + (convertIntToIndex >= 70 ? " ☀️☀️ " : " ☁️☁️ ") + parsedContents[1]
        } else {
            return ""
        }
    }
    
    func parseWorkoutIndexContents(_ contents: String) -> [String] {
        return contents.components(separatedBy: ",")
    }
}
