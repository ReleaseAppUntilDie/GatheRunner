//
//  AuthenticationUITests.swift
//  GatheRunnerTests
//
//  Created by 김동현 on 2022/10/07.
//

import SwiftUI
import XCTest
@testable import GatheRunner

class AuthenticationUITests: BaseUITests {

    override var deviceModel: DeviceModel {
        .iPhoneX
    }

    override var identity: String {
        "Authentication"
    }

    override var viewController: UIViewController {
        AuthenticationView(isSignIn: true).toVC
    }

    override func test_view_on_iPhone() throws {
        try super.test_view_on_iPhone()
    }

}
