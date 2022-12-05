//
//  FirebaseWorkoutIndexRepository.swift
//  GatheRunner
//
//  Created by cho on 2022/11/22.
//

import Foundation
import Combine

struct FirebaseWorkoutIndexRepository: WorkoutIndexRepository {
    func fetch(_ request: TodayWorkoutIndex) -> AnyPublisher<WorkoutIndex, Error> {
        FirebaseAPIManager.shared.fetch(withDocument: request, as: WorkoutIndex.self)
    }
}
