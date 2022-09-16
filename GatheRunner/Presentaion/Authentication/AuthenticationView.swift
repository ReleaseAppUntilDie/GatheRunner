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
        TextField(LabelName.email, text: $email)
            .keyboardType(.emailAddress)
            .disableAutocorrection(true)
            .textFieldStyle(.roundedBorder)
            .frame(width: Size.width, height: Size.height, alignment: .center)
    }

    var passwordField: some View {
        SecureField(LabelName.password, text: $password)
            .textFieldStyle(.roundedBorder)
            .frame(width: Size.width, height: Size.height, alignment: .center)
    }

    var submitButton: some View {
        VStack {
            // MARK: NavigationLink 연산자로 추상화 & 버튼액션 구현 예정

            NavigationLink(destination: MainTabView(), isActive: $isValiid) { EmptyView() }
            Button { } label: { Text(isSignIn ? LabelName.signIn : LabelName.signUp).foregroundColor(.white) }
                .frame(width: Size.width, height: Size.height, alignment: .center)
                .background(Color.blue)
                .cornerRadius(Size.cornerRadius)
        }
    }

    // MARK: Private

    @State private var isValiid = false
    @State private var isSignIn = false

    // MARK: Temp

    @State private var password = ""
    @State private var email = ""

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
