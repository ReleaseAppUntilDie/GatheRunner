//
//  WorkoutIndexResponse.swift
//  GatheRunner
//
//  Created by cho on 2022/11/22.
//

import Foundation

extension WorkoutIndex {
    enum Keys: String, CodingKey {
        case outdoorGrade = "Outdoor_Grade"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        outdoorGrade = try container.decodeIfPresent([String].self, forKey: .outdoorGrade) ?? []
    }
}
