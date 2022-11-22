//
//  WeatherInfoRepository.swift
//  GatheRunner
//
//  Created by cho on 2022/11/09.
//

import Combine

struct WeatherInfoRequest: FireStoreRequestWithDocument {
    var collectionName: String {
        "WeatherInfo"
    }
    
    var documentName: String {
        "Today"
    }
}

struct WeatherInfoResponse: Decodable {
    let content: String?
    let outdoorGrade: String?
    
    enum Keys: String, CodingKey {
        case content = "Content"
        case outdoorGrade = "Outdoor_Grade"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        content = try container.decodeIfPresent(String.self, forKey: .content)
        outdoorGrade = try container.decodeIfPresent(String.self, forKey: .outdoorGrade)
    }
}

class APIs {
    static var cancelBag = Set<AnyCancellable>()
    
    static func fetchWeatherInfo() -> AnyPublisher<WeatherInfoResponse, Error> {
        FirebaseAPIManager.shared.fetch(withDocument: WeatherInfoRequest(), as: WeatherInfoResponse.self)
    }
}
