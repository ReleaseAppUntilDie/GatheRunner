//
//  RunningRecordResponse.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/23.
//

import Foundation

extension RunningRecord {
    enum Keys: String, CodingKey {
        case uid
        case distance
        case averagePace
        case runningTime
        case date
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        uid = try container.decodeIfPresent(String.self, forKey: .uid) ?? Default.empty
        distance = try container.decodeIfPresent(String.self, forKey: .distance) ?? Default.distance
        averagePace = try container.decodeIfPresent(String.self, forKey: .averagePace) ?? Default.averagePace
        runningTime = try container.decodeIfPresent(String.self, forKey: .runningTime) ?? Default.runningTime
        date = try container.decodeIfPresent(String.self, forKey: .runningTime) ?? Default.date
    }
}

// MARK: NameSpace

extension RunningRecord {
    enum Default {
        static let empty = ""
        static let distance = "0"
        static let averagePace = "0"
        static let runningTime = "0"
        static let date = "날짜정보가 없습니다."
    }
}
