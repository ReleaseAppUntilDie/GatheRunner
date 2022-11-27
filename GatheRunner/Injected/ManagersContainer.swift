//
//  ManagersContainer.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/24.
//
extension DependencyContainer {
    struct Managers {
        let userManager: UserManager
    }
}

extension DependencyContainer.Managers {
    init(repositories: DependencyContainer.Repositories) {
        let userManager = UserManager(userRepository: repositories.userRepository)

        self.init(userManager: userManager)
    }
}
