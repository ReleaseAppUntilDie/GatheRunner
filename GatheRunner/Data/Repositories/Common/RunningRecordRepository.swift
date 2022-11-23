//
//  RunningRecordRepository.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/23.
//

import Combine

protocol RunningRecordRepository {
    func post(_ request: RunningRecord) -> AnyPublisher<Bool, Error>
    func fetch(_ request: RecordFetchRequest) -> AnyPublisher<[RunningRecord], Error>
}
