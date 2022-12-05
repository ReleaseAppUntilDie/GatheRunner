//
//  RepositoriesContainer.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/22.
//

extension DependencyContainer {
    struct Repositories {
        let userRepository: UserRepository
        let runningRecordRepository: RunningRecordRepository
        let workoutIndexRepository: WorkoutIndexRepository
    }
}

extension DependencyContainer.Repositories {
    init(with apiType: AppEnvironment.APIType) {
        switch apiType {
        case .FireBase:
            let userRepository = FirebaseUserRepository()
            let runningRecordRepository = FirebaseRunningRecordRepository()
            let workoutIndexRepository = FirebaseWorkoutIndexRepository()
            
            self.init(userRepository: userRepository,
                      runningRecordRepository: runningRecordRepository,
                      workoutIndexRepository: workoutIndexRepository)
        }
    }
}
