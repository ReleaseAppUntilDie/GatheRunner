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
            .frame(width: Size.width, height: Size.height, alignment: .center)
            .asValidationFieldStyle(isValid: $viewModel.isEmailValid)
    }

    var passwordField: some View {
        SecureField(LabelName.password, text: $viewModel.password)
            .frame(width: Size.width, height: Size.height, alignment: .center)
            .asValidationFieldStyle(isValid: $viewModel.isPasswordValid)
    }

    var submitButton: some View {
        VStack {
            // MARK: 환경변수를 통해서 인증시 메인탭뷰로 이동하게 처리 할 예정
            // MARK: 확인 버튼 클릭 후 유효하지 않은 인증정보에 관한 알림처리
            // MARK: 확인 버튼 클릭 후 인증정보 입력창 입력하지 않았을 경우 알림처리
            // MARK: 알림에 사용되는 리터럴 네임스페이스 선언

            Button {
//                showAlert = true
                isSignIn ? viewModel.loginUser() : viewModel.createUser()
            } label: { Text(isSignIn ? LabelName.signIn : LabelName.signUp).foregroundColor(.white) }
                .frame(width: Size.width, height: Size.height, alignment: .center)
                .background(Color.blue)
                .cornerRadius(Size.cornerRadius)
//                .alert(isPresented: $showAlert) {
//                    Alert(title: Text("알림"), message: message, dismissButton: .default(Text("확인")))
//                }
        }
    }

    // MARK: Private

    @State private var isValiid = false
    @State private var isSignIn = false
    @StateObject private var viewModel = AuthenticationViewModel()
}

extension AuthenticationView {

    // MARK: Temp

//    private var message: Text {
//        guard !viewModel.isEmailValid else {
//            return Text("유효하지 않은 이메일 형식 입니다.")
//        }
//        return Text("유효하지 않은 비밀번호 형식 입니다.")
//    }

    private func bindViewModel() {
        viewModel.$isAuthValid
            .dropFirst()
            .compactMap { $0 }
            .sink { isValiid = $0 }
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
