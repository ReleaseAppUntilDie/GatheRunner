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
    let managers: Managers
    
    init(configure appEnvironment: AppEnvironment) {
        let repositories = Repositories(with: appEnvironment.apiType)
        
        self.managers = Managers(repositories: repositories)
        self.viewModels = ViewModels(repositories: repositories, managers: managers)
    }
}
