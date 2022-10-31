//
//  RunningRecordRequest.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/10/31.
//

import Foundation


// MARK: - TEMP: RunningRecordResponseDTO

struct RunningRecordResponseDTO {
    let distance: Int?
    let date: String?

    enum Keys: String, CodingKey {
        case distance = "Distance"
        case date
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        distance = try container.decodeIfPresent(Int.self, forKey: .distance)
        date = try container.decodeIfPresent(String.self, forKey: .date)
    }
}

// MARK: - RunningRecordRequestDTO

struct RunningRecordRequestDTO: Codable {
    let uid: String
    let distance: Int
    let date: String
}
