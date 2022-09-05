//
//  AuthenticationViewModelTests.swift
//  GatheRunnerTests
//
//  Created by 김동현 on 2022/09/01.
//

import Combine
import XCTest
@testable import GatheRunner

class AuthenticationViewModelTests: XCTestCase {

    // MARK: Internal

    override func setUp() {
        super.setUp()
        subscriptions = []
    }

    override func tearDown() {
        viewModel = nil
        service = nil
        super.tearDown()
    }

    func test_authenticationSucceeds() {
        bindViewModel(isSuccess: true)
        viewModel.loginUser()
        XCTAssert(isAuthenticationSucceeds == true)
    }

    func test_authenticationError() {
        bindViewModel(isSuccess: false)
        viewModel.loginUser()
        XCTAssert(isAuthenticationSucceeds == false)
    }

    // MARK: Private

    private var viewModel : AuthenticationViewModel!
    private var service : MockAuthenticationService!
    private var subscriptions = Set<AnyCancellable>()
    private var isAuthenticationSucceeds = true

    private func bindViewModel(isSuccess: Bool) {
        service = MockAuthenticationService(isSuccess: isSuccess)
        viewModel = AuthenticationViewModel(authService: service)
        viewModel.$errorMessage
            .compactMap { $0 }
            .sink { [weak self] _ in
                self?.isAuthenticationSucceeds = false
            }
            .store(in: &subscriptions)
    }
}
