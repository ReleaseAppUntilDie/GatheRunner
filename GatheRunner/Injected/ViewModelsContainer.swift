//
//  ViewModelsContainer.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/22.
//

extension DependencyContainer {
    struct ViewModels {
        private let repositories: DependencyContainer.Repositories
        private let managers: DependencyContainer.Managers
        
        init(repositories: DependencyContainer.Repositories, managers: DependencyContainer.Managers) {
            self.repositories = repositories
            self.managers = managers
        }
    }
}

extension DependencyContainer.ViewModels {
    var authVm: AuthenticationViewModel {
        AuthenticationViewModel(userRepository: repositories.userRepository,
                                userManager: managers.userManager)
    }
    
    var graphVm: GraphViewModel {
        GraphViewModel(runningRecordRepository: repositories.runningRecordRepository,
                       userManager: managers.userManager)
    }
    
    var mapVm: MapViewModel {
        MapViewModel(locationManager: managers.locationManager)
    }
    
    var recordVm: RunningRecordViewModel {
        RunningRecordViewModel(runningRecordRepository: repositories.runningRecordRepository,
                               locationManager: managers.locationManager,
                               timerManager: managers.timerManager,
                               userManager: managers.userManager)
    }
    
    var routeVm: RunningRouteViewModel {
        RunningRouteViewModel(locationManager: managers.locationManager)
    }

}
