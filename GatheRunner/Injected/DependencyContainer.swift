//
//  DependencyContainer.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/18.
//

import Combine

class DependencyContainer: ObservableObject {
    let managers: Managers
    let viewModels: ViewModels
    
    init(configure appEnvironment: AppEnvironment) {
        let repositories = Repositories(with: appEnvironment.apiType)
        
        self.managers = Managers(repositories: repositories)
        self.viewModels = ViewModels(repositories: repositories, managers: managers)
    }
}

extension DependencyContainer {
    static var previewAuthScene = DependencyContainer(configure: .init(apiType: .FireBase)).viewModels.authVm
    static var previewGraphScene = DependencyContainer(configure: .init(apiType: .FireBase)).viewModels.graphVm
    static var previewMapScene = DependencyContainer(configure: .init(apiType: .FireBase)).viewModels.mapVm
    static var previewRecordScene = DependencyContainer(configure: .init(apiType: .FireBase)).viewModels.recordVm
    static var previewRouteScene = DependencyContainer(configure: .init(apiType: .FireBase)).viewModels.routeVm
}
