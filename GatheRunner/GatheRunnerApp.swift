//
//  GatheRunnerApp.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/06/29.
//

import FirebaseCore
import SwiftUI

@main
struct GatheRunnerApp: App {
    @ObservedObject var container: DependencyContainer
    @ObservedObject var userManager: UserManager
    
    init() {
        FirebaseApp.configure()
        
        let appEnvironment = AppEnvironment(apiType: .FireBase)
        let container = DependencyContainer(configure: appEnvironment)
        
        self.container = container
        self.userManager = container.managers.userManager
    }
    
    var body: some Scene {
        WindowGroup {
            if userManager.isSignIn {
                MainTabView().environmentObject(container)
            } else {
                AuthenticationView(viewModel: container.viewModels.authVm)
            }
        }
    }
}
