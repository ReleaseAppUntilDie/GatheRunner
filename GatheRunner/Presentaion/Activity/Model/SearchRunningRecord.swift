//
//  SearchRunningRecord.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/30.
//

struct SearchRunningRecord: Codable {
    let uid: String
}

// MARK: Temp Condition

extension SearchRunningRecord {
    struct Details: Codable, Equatable {
        let dateRange: [String]
    }
}
