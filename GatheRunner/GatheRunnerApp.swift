//
//  GatheRunnerApp.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/06/29.
//


import FirebaseCore
import SwiftUI

// MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey : Any]? = nil)
        -> Bool
    {
        FirebaseApp.configure()
        return true
    }
}

// MARK: - GatheRunnerApp

@main
struct GatheRunnerApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
