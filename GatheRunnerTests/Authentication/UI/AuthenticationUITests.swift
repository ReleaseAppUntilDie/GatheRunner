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

    override var targetModel: DeviceModel {
        .iPhoneX
    }

    override var identity: ViewIdentity {
        .authentication
    }

    override var targetView: UIViewController {
        AuthenticationView().convertedVC
    }

    override var isRecord: Bool {
        false
    }

    override func test_view_on_iPhone() throws {
        try super.test_view_on_iPhone()
    }

    override func test_view_on_iPhone_landscape() throws {
        try super.test_view_on_iPhone_landscape()
    }
}
