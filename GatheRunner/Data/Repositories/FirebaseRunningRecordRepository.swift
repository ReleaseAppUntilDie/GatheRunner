//
//  FirebaseRunningRecordRepository.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/23.
//

import Foundation
import Combine

struct FirebaseRunningRecordRepository: RunningRecordRepository {
    func post(_ request: RunningRecord) -> AnyPublisher<Bool, Error> {
        FirebaseAPIManager.shared.fetch(withQuery: request, as: Bool.self)
    }
    
    func fetch(_ request: RecordFetchRequest) -> AnyPublisher<[RunningRecord], Error> {
        FirebaseAPIManager.shared.fetch(withQuery: request, as: RunningRecord.self)
    }
}
