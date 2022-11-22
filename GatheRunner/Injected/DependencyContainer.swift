//
//  DependencyContainer.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/18.
//

import Combine

class DependencyContainer: ObservableObject {
    let viewModels: ViewModels
    
    init(configure appEnvironment: AppEnvironment) {
        let repositories = Repositories(with: appEnvironment.apiType)
        self.viewModels = ViewModels(with: repositories)
    }
}
