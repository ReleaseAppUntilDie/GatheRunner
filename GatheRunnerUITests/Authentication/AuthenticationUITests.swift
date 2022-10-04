//
//  AuthenticationUITests.swift
//  GatheRunnerTests
//
//  Created by 김동현 on 2022/10/02.
//

import ViewInspector
import XCTest
@testable import GatheRunner

// MARK: - AuthenticationView + Inspectable

extension AuthenticationView: Inspectable { }

// MARK: - AuthenticationUITests

class AuthenticationUITests: XCTestCase {
    func test_authentication_signInState() throws {
        let content = try AuthenticationView(isSignIn: true)
            .inspect()
            .find(viewWithId: "submitButton")
            .button()
            .labelView()
            .text()
            .string()

        XCTAssertEqual(content, "로그인")
    }
}
