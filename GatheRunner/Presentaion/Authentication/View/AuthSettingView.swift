//
//  AuthSettingView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/11/19.
//

import SwiftUI

struct AuthSettingView: View {
    private enum Size {
        static let spacing: CGFloat = 20
    }
    
    private enum Label {
        static let userInfoSetting = "회원정보 설정"
        static let signOut = "로그아웃"
        static let deleteUser = "회원탈퇴"
        static let cancle = "취소"
        static let confirm = "확인"
        static let alertTitle = "알림"
    }
    
    @Binding var isShownSheet: Bool
    @StateObject var viewModel: AuthenticationViewModel
    @State private var isShownAlert = false
    
    var body: some View {
        buttonLayer
            .didSetLoadable(by: $viewModel.fetchStatus)
            .onAppear { bindFetch() }
            .alert(isPresented: $isShownAlert) {
                Alert(
                    title: Text(Label.alertTitle),
                    message: Text(viewModel.errorMessage),
                    dismissButton: .default(Text(Label.confirm)))
            }
    }
    
    private var buttonLayer: some View {
        VStack(spacing: Size.spacing) {
            Button(Label.signOut) {
                viewModel.signOut()
            }
            Button(Label.deleteUser) {
                viewModel.deleteUser()
            }
            Button(Label.cancle) {
                isShownSheet.toggle()
            }
        }
    }
    
    private func bindFetch() {
        viewModel.$fetchStatus
            .sink {
                switch $0 {
                case .success: isShownSheet.toggle()
                case .failure: isShownAlert.toggle()
                default: return
                }
            }
            .store(in: &viewModel.cancelBag)
    }
}
