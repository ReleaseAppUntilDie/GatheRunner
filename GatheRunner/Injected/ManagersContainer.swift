//
//  ManagersContainer.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/24.
//
extension DependencyContainer {
    struct Managers { }
}

extension DependencyContainer.Managers {
    init(repositories: DependencyContainer.Repositories) {
        
        self.init()
    }
}
