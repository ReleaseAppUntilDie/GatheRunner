//
//  TodayWorkoutIndex+Firebase.swift
//  GatheRunner
//
//  Created by cho on 2022/11/22.
//

struct TodayWorkoutIndex: FireStoreRequestWithDocument {
    var collectionName: String {
        "WeatherInfo"
    }
    
    var documentName: String {
        "Today"
    }
}
