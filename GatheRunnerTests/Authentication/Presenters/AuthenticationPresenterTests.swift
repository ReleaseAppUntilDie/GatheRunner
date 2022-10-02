//
//  AuthenticationPresentersTests.swift
//  GatheRunnerTests
//
//  Created by 김동현 on 2022/09/29.
//

import XCTest

// MARK: - AuthenticationPresenterTests

class AuthenticationPresenterTests: XCTestCase {

    // MARK: Internal

    var mocksInputsValidatorProtocol: MocksInputsValidatorProtocol!
    var isPassEmailValidation: Bool!
    var isPassPasswordValidation: Bool!

    override func setUpWithError() throws {
        mocksInputsValidatorProtocol = MocksInputsValidatorProtocol()
        isPassEmailValidation = false
        isPassPasswordValidation = false
        bindValidatorProtocol()
    }

    override func tearDownWithError() throws {
        mocksInputsValidatorProtocol = nil
    }

    func testAuthenticationPresenter_EmailVerification_ShouldFail() {
        // MARK: choose madeOverLengthExample(isTestWithEmail: true) or madeInValidFormatExample()

        let example = madeInvalidFormatExample()
        mocksInputsValidatorProtocol.didValidation(isTestWithEmail: true, exampelBy: example)
        XCTAssert(isPassEmailValidation == false)
    }

    func testAuthenticationPresenter_EmailVerification_ShouldSucceed() {
        let example = madeValidExample(isTestWithEmail: true)
        mocksInputsValidatorProtocol.didValidation(isTestWithEmail: true, exampelBy: example)
        XCTAssert(isPassEmailValidation == true)
    }

    func testAuthenticationPresenter_PasswordVerification_ShouldFail() {
        // MARK: choose madeOverLengthExample(isTestWithEmail: false) or madeInValidFormatExample()

        let example = madeOverLengthExample(isTestWithEmail: false)
        mocksInputsValidatorProtocol.didValidation(isTestWithEmail: false, exampelBy: example)
        XCTAssert(isPassEmailValidation == false)
    }

    func testAuthenticationPresenter_PasswordVerification_ShouldSucceed() {
        let example = madeValidExample(isTestWithEmail: false)
        mocksInputsValidatorProtocol.didValidation(isTestWithEmail: false, exampelBy: example)
        XCTAssert(isPassPasswordValidation == true)
    }

    // MARK: Private

    private enum Content {
        static let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        static let lettersAndNumbers = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        static let emailDomainExample = "@example.com"
        static let specialCharacters = "!1@2#3"
    }

    private func bindValidatorProtocol() {
        mocksInputsValidatorProtocol.$isEmailValid
            .sink { [weak self] result in
                self?.isPassEmailValidation = result
            }
            .store(in: &mocksInputsValidatorProtocol.cancelBag)

        mocksInputsValidatorProtocol.$isPasswordValid
            .sink { [weak self] result in
                self?.isPassPasswordValidation = result
            }
            .store(in: &mocksInputsValidatorProtocol.cancelBag)
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
}

// MARK: Helper+CreateRandomStr

extension AuthenticationPresenterTests {
    private func createRandomStr(by text: String, length: Int) -> String {
        String((0 ..< length).map { _ in text.randomElement()! })
    }
}
