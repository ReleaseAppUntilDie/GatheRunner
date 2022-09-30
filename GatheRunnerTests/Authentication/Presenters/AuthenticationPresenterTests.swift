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
    var isEmailValidTestResult: Bool!
    var isPasswordValidTestResult: Bool!

    override func setUpWithError() throws {
        mocksInputsValidatorProtocol = MocksInputsValidatorProtocol()
        isEmailValidTestResult = false
        isPasswordValidTestResult = false
        bindValidatorProtocol()
    }

    override func tearDownWithError() throws {
        mocksInputsValidatorProtocol = nil
    }

    func testAuthenticationPresenter_EmailVerification_ShouldFail() {
        // MARK: choose method madeOverLengthExample(isEmail: true) or madeInValidFormatExample()

        let example = madeInValidFormatExample()
        mocksInputsValidatorProtocol.didValidation(isEmailTest: true, exampelBy: example)
        XCTAssert(isEmailValidTestResult == false)
    }

    func testAuthenticationPresenter_EmailVerification_ShouldSucceed() {
        let example = madeValidExample(isEmailTest: true)
        mocksInputsValidatorProtocol.didValidation(isEmailTest: true, exampelBy: example)
        XCTAssert(isEmailValidTestResult == true)
    }

    func testAuthenticationPresenter_PasswordVerification_ShouldFail() {
        // MARK: choose method madeOverLengthExample(isEmailTest: false) or madeInValidFormatExample()

        let example = madeOverLengthExample(isEmailTest: false)
        mocksInputsValidatorProtocol.didValidation(isEmailTest: false, exampelBy: example)
        XCTAssert(isEmailValidTestResult == false)
    }

    func testAuthenticationPresenter_PasswordVerification_ShouldSucceed() {
        let example = madeValidExample(isEmailTest: false)
        mocksInputsValidatorProtocol.didValidation(isEmailTest: false, exampelBy: example)
        XCTAssert(isPasswordValidTestResult == true)
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
            .dropFirst()
            .compactMap { $0 }
            .sink { [weak self] result in
                self?.isEmailValidTestResult = result
            }
            .store(in: &mocksInputsValidatorProtocol.cancelBag)

        mocksInputsValidatorProtocol.$isPasswordValid
            .dropFirst()
            .compactMap { $0 }
            .sink { [weak self] result in
                self?.isPasswordValidTestResult = result
            }
            .store(in: &mocksInputsValidatorProtocol.cancelBag)
    }

    // MARK: Email Length Range 0 - 30 && Password Length Range 8 - 20

    private func madeValidExample(isEmailTest: Bool, length: Int = 10) -> String {
        let result = createRandomStr(material: Content.lettersAndNumbers, length: length)
        return isEmailTest ? result + Content.emailDomainExample : result + Content.specialCharacters
    }

    private func madeOverLengthExample(isEmailTest: Bool, length: Int = 40) -> String {
        let result = createRandomStr(material: Content.lettersAndNumbers, length: length)
        return isEmailTest ? result + Content.emailDomainExample : result
    }

    private func madeInValidFormatExample(length: Int = 10) -> String {
        createRandomStr(material: Content.letters, length: length)
    }
}

// MARK: Helper+CreateRandomStr

extension AuthenticationPresenterTests {
    private func createRandomStr(material: String, length: Int) -> String {
        String((0 ..< length).map { _ in material.randomElement()! })
    }
}
