//
//  AuthenticationPresentersTests.swift
//  GatheRunnerTests
//
//  Created by 김동현 on 2022/09/29.
//

import XCTest

// MARK: - AuthenticationPresenterTests

class AuthenticationPresenterTests: XCTestCase {
    typealias InputType = MocksInputsValidator.InputType

    var mocksInputsValidator: MocksInputsValidator!
    var isPassEmailValidation: Bool!
    var isPassPasswordValidation: Bool!

    override func setUpWithError() throws {
        mocksInputsValidator = MocksInputsValidator()
        isPassEmailValidation = false
        isPassPasswordValidation = false
        bindValidatorProtocol()
    }

    override func tearDownWithError() throws {
        mocksInputsValidator = nil
    }

    func testAuthenticationPresenter_EmailVerification_ShouldFail() {
        mocksInputsValidator.inputTestSample(.email, with: example(.email, type: .invalidFormat))
        XCTAssert(isPassEmailValidation == false)
    }

    func testAuthenticationPresenter_EmailVerification_ShouldSucceed() {
        mocksInputsValidator.inputTestSample(.email, with: example(.email, type: .valid))
        XCTAssert(isPassEmailValidation == true)
    }

    func testAuthenticationPresenter_PasswordVerification_ShouldFail() {
        mocksInputsValidator.inputTestSample(.password, with: example(.password, type: .overLength))
        XCTAssert(isPassEmailValidation == false)
    }

    func testAuthenticationPresenter_PasswordVerification_ShouldSucceed() {
        mocksInputsValidator.inputTestSample(.password, with: example(.password, type: .valid))
        XCTAssert(isPassPasswordValidation == true)
    }
}

// MARK: Private NamsSpaces

extension AuthenticationPresenterTests {
    private enum Content {
        static let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        static let lettersAndNumbers = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        static let emailDomainExample = "@example.com"
        static let specialCharacters = "!1@2#3"
    }

    private enum Option {
        enum Length: Int {
            case zero = 0
            case validLength = 10
            case overLength = 40
        }

        enum Example {
            case valid
            case overLength
            case invalidFormat
        }
    }
}

// MARK: Private Methods

extension AuthenticationPresenterTests {
    private func bindValidatorProtocol() {
        mocksInputsValidator.$isEmailValid
            .sink { [weak self] result in
                self?.isPassEmailValidation = result
            }
            .store(in: &mocksInputsValidator.cancelBag)

        mocksInputsValidator.$isPasswordValid
            .sink { [weak self] result in
                self?.isPassPasswordValidation = result
            }
            .store(in: &mocksInputsValidator.cancelBag)
    }

    /// Current Email Length Range 0 - 30 && Current Password Length Range 8 - 20

    private func example(_ inputType: InputType, type: Option.Example) -> String {
        switch type {
        case .valid:
            let result = randomText(by: Content.lettersAndNumbers, length: .validLength)
            return inputType == .email ? result + Content.emailDomainExample : result + Content.specialCharacters
        case .overLength:
            let result = randomText(by: Content.lettersAndNumbers, length: .overLength)
            return inputType == .email ? result + Content.emailDomainExample : result + Content.specialCharacters
        case .invalidFormat:
            return randomText(by: Content.letters, length: .overLength)
        }
    }

    private func randomText(by text: String, length: Option.Length) -> String {
        String((Option.Length.zero.rawValue ..< length.rawValue).map { _ in text.randomElement()! })
    }
}
