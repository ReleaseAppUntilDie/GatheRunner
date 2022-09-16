//
//  AuthenticationView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/09/16.
//

import SwiftUI

// MARK: - AuthenticationView

struct AuthenticationView: View {

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

    var fieldLayer: some View {
        VStack(spacing: Size.spacing) {
            Picker(LabelName.empty, selection: $isSignIn) {
                Text(LabelName.signIn).tag(true)
                Text(LabelName.signUp).tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            emailField
            passwordField
        }
    }

    var emailField: some View {
        TextField(LabelName.email, text: $viewModel.email)
            .keyboardType(.emailAddress)
            .disableAutocorrection(true)
            .textFieldStyle(.roundedBorder)
            .frame(width: Size.width, height: Size.height, alignment: .center)
            .alert(isPresented: $viewModel.isNotEmailValid) {
                Alert(title: Text("이메일"), message: Text("This is a alert message"), dismissButton: .default(Text("Dismiss")))
            }
    }

    var passwordField: some View {
        SecureField(LabelName.password, text: $viewModel.password)
            .textFieldStyle(.roundedBorder)
            .frame(width: Size.width, height: Size.height, alignment: .center)
    }

    var submitButton: some View {
        VStack {
            // MARK: 환경변수를 통해서 인증시 메인탭뷰로 이동하게 처리 할 예정

            Button {
                isSignIn ? viewModel.loginUser() : viewModel.createUser()
            } label: { Text(isSignIn ? LabelName.signIn : LabelName.signUp).foregroundColor(.white) }
                .frame(width: Size.width, height: Size.height, alignment: .center)
                .background(Color.blue)
                .cornerRadius(Size.cornerRadius)
        }
    }

    // MARK: Private

    @State private var isValiid = false
    @State private var isSignIn = false
    @StateObject private var viewModel = AuthenticationViewModel()
}

extension AuthenticationView {
    private func bindViewModel() {
        viewModel.$isAuthValid
            .dropFirst()
            .compactMap { $0 }
            .sink(receiveValue: { result in
                isValiid = result
            })
            .store(in: &viewModel.cancelBag)
    }
}

// MARK: NameSpace

extension AuthenticationView {

    private enum LabelName {
        static let signIn = "로그인"
        static let signUp = "회원가입"
        static let email = "이메일"
        static let password = "패스워드"
        static let empty = ""
    }

    private enum Size {
        static let width: CGFloat = 280
        static let height: CGFloat = 45
        static let spacing: CGFloat = 16
        static let cornerRadius: CGFloat = 8
    }

}

// MARK: - AuthenticationView_Previews

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
