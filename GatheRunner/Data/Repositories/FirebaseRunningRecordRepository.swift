//
//  FirebaseRunningRecordRepository.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/23.
//

import Foundation
import Combine

struct FirebaseRunningRecordRepository: RunningRecordRepository {
    func post(_ request: RunningRecordRequest) -> AnyPublisher<Bool, Error> {
        FirebaseAPIManager.shared.fetch(withQuery: request, as: Bool.self)
    }
    
    func fetch(_ request: RunningRecordRequest) -> AnyPublisher<[RunningRecordResponse], Error> {
        FirebaseAPIManager.shared.fetch(withQuery: request, as: RunningRecordResponse.self)
    }
}
