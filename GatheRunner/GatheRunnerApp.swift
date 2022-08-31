//
//  GatheRunnerApp.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/06/29.
//


import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct GatheRunnerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            
            // MARK: - 자동로그인 관련 기능 구현전까지, 임시로 무조건 인증화면 거치게 구현

            AuthenticationView()
        }
    }
}
