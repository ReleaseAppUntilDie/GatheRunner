//
//  RunningRecord+Firebase.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/30.
//

extension RunningRecord: FireStoreRequestWithQuery {
    var collectionName: String {
        "RunningRecord"
    }
}