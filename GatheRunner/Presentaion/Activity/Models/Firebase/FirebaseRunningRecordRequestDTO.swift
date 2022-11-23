//
//  FirebaseRunningRecordRequestDTO.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/23.
//

extension RunningRecordRequest: FireStoreRequestWithQuery {
    var collectionName: String {
        "RunningRecord"
    }
}
