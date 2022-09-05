//
//  AuthView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/08/27.
//

import Combine
import SwiftUI

// MARK: - AuthenticationView

struct AuthenticationView: View {

    // MARK: Internal

    @State var isLink = false

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                authPicker
                emailField
                passwordField
                Spacer()
                submitButton
                signInNaviLink
            }
            .navigationTitle(isLogin ? "Welcome Back" : "Welcome")
            .onAppear { bind() }
        }
    }

    var authPicker: some View {
        Picker("", selection: $isLogin) {
            Text("Log In").tag(true)
            Text("Create Account").tag(false)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }

    var emailField: some View {
        TextField("Email", text: $viewModel.email)
            .keyboardType(.emailAddress)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .textFieldStyle(.roundedBorder)
            .frame(width: 280, height: 45, alignment: .center)
    }

    var passwordField: some View {
        SecureField("Password", text: $viewModel.password)
            .textFieldStyle(.roundedBorder)
            .frame(width: 280, height: 45, alignment: .center)
    }

    var submitButton: some View {
        Button(action: {
            isLogin ? viewModel.loginUser() : viewModel.createUser()
        }, label: {
            Text(isLogin ? "Log In" : "Create Account").foregroundColor(.white)
        })
        .frame(width: 280, height: 45, alignment: .center)
        .background(Color.blue)
        .cornerRadius(8)
    }

    var signInNaviLink: some View {
        NavigationLink(
            destination: MainTabView(),
            isActive: $isLink,
            label: { EmptyView() })
    }

    // MARK: Private

    @State private var isLogin = false
    @StateObject private var viewModel = AuthenticationViewModel()
}

extension AuthenticationView {
    func bind() {
        viewModel.$isValid
            .dropFirst()
            .compactMap { $0 }
            .sink(receiveValue: { result in
                isLink = result
            })
            .store(in: &viewModel.cancelBag)
    }
}

// MARK: - AuthenticationView_Previews

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
