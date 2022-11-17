//
//  AuthenticationView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/09/16.
//

import SwiftUI

// MARK: - AuthenticationView

struct AuthenticationView: View {
    @EnvironmentObject var authenticator: Authenticator

    // MARK: Internal

    var body: some View {
        NavigationView {
            VStack {
                fieldLayer

                Spacer()

                submitButton
            }
        }
        .onAppear { bindViewModel() }
    }

    // MARK: Private

    private enum Size {
        static let width: CGFloat = 280
        static let height: CGFloat = 45
        static let spacing: CGFloat = 16
        static let cornerRadius: CGFloat = 8
    }

    private enum Content {
        enum Label {
            static let signIn = "로그인"
            static let signUp = "회원가입"
            static let email = "이메일"
            static let password = "패스워드"
            static let empty = ""
            static let alertTitle = "알림"
            static let confirm = "확인"
        }

        enum Message {
            static let inputRequest = "을(를) 입력해주세요."
            static let inputError = "이(가) 유효하지 않습니다."
            static let authFailed = "인증에 실패했습니다."
        }
    }

    @State private var isValid = false
    @State private var isSignIn = false
    @State private var isAlertShow = false
    @StateObject private var viewModel = AuthenticationViewModel(userRepository: FirebaseUserRepository())

    private var alertMessage: Text? {
        switch true {
        case viewModel.email.isEmpty: return Text(Content.Label.email + Content.Message.inputRequest)
        case viewModel.password.isEmpty: return Text(Content.Label.password + Content.Message.inputRequest)
        case !viewModel.isEmailValid: return Text(Content.Label.email + Content.Message.inputError)
        case !viewModel.isPasswordValid: return Text(Content.Label.password + Content.Message.inputError)
        case !viewModel.isAuthValid: return Text(Content.Message.authFailed)
        default: return nil
        }
    }
}

extension AuthenticationView {
    private func bindViewModel() {
        viewModel.$isInputsValid
            .dropFirst()
            .compactMap { $0 }
            .sink { isAlertShow = !$0 }
            .store(in: &viewModel.cancelBag)

        viewModel.$isAuthValid
            .dropFirst()
            .compactMap { $0 }
            .sink {
                isValid = $0
                authenticator.isSignIn = true
            }
            .store(in: &viewModel.cancelBag)
    }
}

// MARK: SubViews

extension AuthenticationView {
    private var fieldLayer: some View {
        VStack(spacing: Size.spacing) {
            fieldPicker
            emailField
            passwordField
        }
    }

    private var fieldPicker: some View {
        Picker(Content.Label.empty, selection: $isSignIn) {
            Text(Content.Label.signIn).tag(true)
            Text(Content.Label.signUp).tag(false)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }

    private var emailField: some View {
        TextField(Content.Label.email, text: $viewModel.email)
            .keyboardType(.emailAddress)
            .disableAutocorrection(true)
            .frame(width: Size.width, height: Size.height, alignment: .center)
            .asValidationFieldStyle(isValid: $viewModel.isEmailValid)
    }

    private var passwordField: some View {
        SecureField(Content.Label.password, text: $viewModel.password)
            .frame(width: Size.width, height: Size.height, alignment: .center)
            .asValidationFieldStyle(isValid: $viewModel.isPasswordValid)
    }

    private var submitButton: some View {
        VStack {
            Button {
                isSignIn ? viewModel.signIn(authenticator: authenticator) : viewModel.signUp(authenticator: authenticator)
            } label: { Text(isSignIn ? Content.Label.signIn : Content.Label.signUp).foregroundColor(.white) }
                .frame(width: Size.width, height: Size.height, alignment: .center)
                .background(Color.blue)
                .cornerRadius(Size.cornerRadius)
                .alert(isPresented: $isAlertShow) {
                    Alert(
                        title: Text(Content.Label.alertTitle),
                        message: alertMessage,
                        dismissButton: .default(Text(Content.Label.confirm)))
                }
        }
    }
}

// MARK: - AuthenticationView_Previews

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
