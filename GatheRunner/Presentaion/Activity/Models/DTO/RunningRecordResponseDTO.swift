//
//  RunningRecordResponseDTO.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/23.
//

import Foundation

struct HistoryModel: Hashable {
    let distance: String
    let averagePace: String
    let runningTime: String
    let date: String
    let weekday: String
}

struct AverageHistory {
    let distance: String
    let runningCnt: Int
    let averagePace: String
    let totalTime: String
}

extension RunningRecord {
    var toHistory: HistoryModel {
        return .init(distance: distance, averagePace: averagePace, runningTime: runningTime, date: date, weekday: date.toWeekday)
    }
}
