//
//  WorkoutIndexRepository.swift
//  GatheRunner
//
//  Created by cho on 2022/11/22.
//

import Combine

struct WorkoutIndexRequest: FireStoreRequestWithDocument {
    var collectionName: String {
        "WeatherInfo"
    }
    
    var documentName: String {
        "Today"
    }
}

struct WorkoutIndexResponse: Decodable {
    let outdoorGrade: [String]?
    
    enum Keys: String, CodingKey {
        case outdoorGrade = "Outdoor_Grade"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        outdoorGrade = try container.decodeIfPresent(Array<String>.self, forKey: .outdoorGrade)!
    }
}

class WorkoutIndexFetchAPIs {
    static var cancelBag = Set<AnyCancellable>()
    
    static func fetchWorkoutIndex() -> AnyPublisher<WorkoutIndexResponse, Error> {
        FirebaseAPIManager.shared.fetch(withDocument: WorkoutIndexRequest(), as: WorkoutIndexResponse.self)
    }
}
