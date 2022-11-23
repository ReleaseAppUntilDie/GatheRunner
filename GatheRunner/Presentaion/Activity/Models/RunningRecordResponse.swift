//
//  RunningRecordResponse.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/23.
//

import Foundation

struct RunningRecordResponse: Decodable, Hashable {
    let uid: String?
    let distance: String?
    let averagePace: String?
    let runningTime: String?
    let date: String?
    
    enum Keys: String, CodingKey {
        case uid
        case distance
        case averagePace
        case runningTime
        case date
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        uid = try container.decodeIfPresent(String.self, forKey: .uid) ?? ""
        distance = try container.decodeIfPresent(String.self, forKey: .distance) ?? Default.distance
        averagePace = try container.decodeIfPresent(String.self, forKey: .averagePace) ?? Default.averagePace
        runningTime = try container.decodeIfPresent(String.self, forKey: .runningTime) ?? Default.runningTime
        date = try container.decodeIfPresent(String.self, forKey: .runningTime) ?? Default.date
    }
}

// MARK: NameSpace

extension RunningRecordResponse {
    enum Default {
        static let distance = "0"
        static let averagePace = "0"
        static let runningTime = "0"
        static let date = ""
    }
}
