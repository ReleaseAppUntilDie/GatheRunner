//
//  WeatherInfoViewModel.swift
//  GatheRunner
//
//  Created by cho on 2022/11/16.
//

import Combine

class WeatherInfoViewModel: ObservableObject {
    @Published var content: String?
    @Published var outdoorGrade: String?
    
    init() {
        APIs.fetchWeatherInfo()
            .sink { [weak self] completion in
                switch completion {
                case .failure(_):
                    print("fetch WeatherInfo Error")
                default:
                    print("fetch WeatherInfo Completion \(completion)")
                }
            } receiveValue: { result in
                self.content = result.content ?? ""
                self.outdoorGrade = result.outdoorGrade ?? ""
            }.store(in: &APIs.cancelBag)
    }
}
