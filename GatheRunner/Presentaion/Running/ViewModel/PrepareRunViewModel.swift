//
//  WeatherInfoViewModel.swift
//  GatheRunner
//
//  Created by cho on 2022/11/16.
//

import Combine

class PrepareRunViewModel: ObservableObject {
    @Published var content: String?
    @Published var outdoorGrade: String?
    
    func getWorkoutIndex() {
        APIs.fetchWeatherInfo()
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    print("fetch workoutIndex Error")
                default:
                    print("fetch workoutIndex Completion \(completion)")
                }
            } receiveValue: { result in
                self.content = result.content ?? ""
                self.outdoorGrade = result.outdoorGrade ?? ""
            }.store(in: &APIs.cancelBag)
    }
    
    func getWorkoutIndexContents() -> String {
        if let outdoorGrade = self.outdoorGrade, let content = self.content, let convertIntToOutdoorGrade = Int(self.outdoorGrade!) {
            return "오늘의 운동 지수 : " + outdoorGrade + (convertIntToOutdoorGrade >= 70 ? " ☀️☀️ " : " ☁️☁️ ") + content
        } else {
            return ""
        }
    }
}
