//
//  ViewModelsContainer.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/22.
//

extension DependencyContainer {
    struct ViewModels { }
}

extension DependencyContainer.ViewModels {
    init(with repositories: DependencyContainer.Repositories) {
        
        self.init()
    }
}
