//
//  ManagersContainer.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/24.
//
extension DependencyContainer {
    struct Managers {
        let userManager: UserManager
        let locationManager: LocationManager
        let timerManager: TimerManager
    }
}

extension DependencyContainer.Managers {
    init(repositories: DependencyContainer.Repositories) {
        let userManager = UserManager(userRepository: repositories.userRepository)
        let locationManager = LocationManager()
        let timerManager = TimerManager()

        self.init(userManager: userManager,
                  locationManager: locationManager,
                  timerManager: timerManager)
    }
}
