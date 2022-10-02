//
//  AuthenticationPresentersTests.swift
//  GatheRunnerTests
//
//  Created by 김동현 on 2022/09/29.
//

import XCTest

// MARK: - AuthenticationPresenterTests

class AuthenticationPresenterTests: XCTestCase {

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
        // MARK: choose madeOverLengthExample(isTestWithEmail: true) or madeInValidFormatExample()

        let example = madeInvalidFormatExample()
        mocksInputsValidator.didValidation(isTestWithEmail: true, by: example)
        XCTAssert(isPassEmailValidation == false)
    }

    func testAuthenticationPresenter_EmailVerification_ShouldSucceed() {
        let example = madeValidExample(isTestWithEmail: true)
        mocksInputsValidator.didValidation(isTestWithEmail: true, by: example)
        XCTAssert(isPassEmailValidation == true)
    }

    func testAuthenticationPresenter_PasswordVerification_ShouldFail() {
        // MARK: choose madeOverLengthExample(isTestWithEmail: false) or madeInValidFormatExample()

        let example = madeOverLengthExample(isTestWithEmail: false)
        mocksInputsValidator.didValidation(isTestWithEmail: false, by: example)
        XCTAssert(isPassEmailValidation == false)
    }

    func testAuthenticationPresenter_PasswordVerification_ShouldSucceed() {
        let example = madeValidExample(isTestWithEmail: false)
        mocksInputsValidator.didValidation(isTestWithEmail: false, by: example)
        XCTAssert(isPassPasswordValidation == true)
    }
}

// MARK: Private NamsSpace & Methods

extension AuthenticationPresenterTests {
    private enum Content {
        static let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        static let lettersAndNumbers = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        static let emailDomainExample = "@example.com"
        static let specialCharacters = "!1@2#3"
    }

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

    // MARK: Email Length Range 0 - 30 && Password Length Range 8 - 20

    private func madeValidExample(isTestWithEmail: Bool, length: Int = 10) -> String {
        let result = createRandomStr(by: Content.lettersAndNumbers, length: length)
        return isTestWithEmail ? result + Content.emailDomainExample : result + Content.specialCharacters
    }

    private func madeOverLengthExample(isTestWithEmail: Bool, length: Int = 40) -> String {
        let result = createRandomStr(by: Content.lettersAndNumbers, length: length)
        return isTestWithEmail ? result + Content.emailDomainExample : result
    }

    private func madeInvalidFormatExample(length: Int = 10) -> String {
        createRandomStr(by: Content.letters, length: length)
    }

    private func createRandomStr(by text: String, length: Int) -> String {
        String((0 ..< length).map { _ in text.randomElement()! })
    }
}
