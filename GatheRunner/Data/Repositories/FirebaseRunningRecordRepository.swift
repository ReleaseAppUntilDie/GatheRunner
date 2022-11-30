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
        FirebaseAPIManager.shared.post(request: request)
    }
    
    func fetch(_ request: SearchRunningRecord) -> AnyPublisher<[RunningRecord], Error> {
        FirebaseAPIManager.shared.fetch(withQuery: request, as: RunningRecord.self)
    }
}