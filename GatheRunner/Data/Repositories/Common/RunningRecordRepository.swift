//
//  RunningRecordRepository.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/23.
//

import Combine

protocol RunningRecordRepository {
    func post(_ request: RunningRecordRequest) -> AnyPublisher<Bool, Error>
    func fetch(_ request: RunningRecordRequest) -> AnyPublisher<[RunningRecordResponse], Error>
}
