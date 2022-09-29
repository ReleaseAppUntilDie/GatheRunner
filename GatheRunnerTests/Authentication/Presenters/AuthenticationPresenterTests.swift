//
//  AuthenticationPresentersTests.swift
//  GatheRunnerTests
//
//  Created by 김동현 on 2022/09/29.
//

import XCTest

class AuthenticationPresenterTests: XCTestCase {

    // MARK: Internal

    var mocksInputsValidatorProtocol: MocksInputsValidatorProtocol!
    var isEmailValid: Bool!

    override func setUpWithError() throws {
        mocksInputsValidatorProtocol = MocksInputsValidatorProtocol()
        isEmailValid = false
    }

    override func tearDownWithError() throws {
        mocksInputsValidatorProtocol = nil
    }

    func testAuthenticationPresenter_WhenValidated_ShouldFail() {
        mocksInputsValidatorProtocol.didValidation(testSample: "failed")
        XCTAssert(isEmailValid == false)
    }

    // MARK: Private


    private func bindValidatorProtocol() {
        mocksInputsValidatorProtocol.$isEmailValid
            .dropFirst()
            .compactMap { $0 }
            .sink { [weak self] _ in
                self?.isEmailValid = false
            }
            .store(in: &mocksInputsValidatorProtocol.cancelBag)
    }
}
