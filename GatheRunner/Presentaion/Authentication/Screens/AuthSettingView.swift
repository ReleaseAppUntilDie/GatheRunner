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
    }
    
    @Binding var isShownSheet: Bool
    @StateObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack(spacing: Size.spacing) {
            Button(Label.signOut) {
                viewModel.signOut()
                isShownSheet.toggle()
            }
            Button(Label.deleteUser) {
                viewModel.deleteUser()
                isShownSheet.toggle()
            }
            Button(Label.cancle) {
                isShownSheet.toggle()
            }
        }
    }
}
