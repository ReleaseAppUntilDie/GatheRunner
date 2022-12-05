//
//  WorkoutIndexRepository.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/12/05.
//

import Combine

protocol WorkoutIndexRepository {
    func fetch(_ request: TodayWorkoutIndex) -> AnyPublisher<WorkoutIndex, Error>
}
