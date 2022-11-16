//
//  HeaderView.swift
//  GatheRunner
//
//  Created by jaeseung han on 2022/07/07.
//
import SwiftUI

// MARK: - ViewsInHeaderView

enum ViewsInHeaderView {
    case home,running,club,activity
}

// MARK: - HeaderView

struct HeaderView: View {
    @EnvironmentObject var authenticator: Authenticator
    
    let title: String
    let type: ViewsInHeaderView
    let rightButtonAction: () -> Void
    
    @State private var showingAlert = false
    @StateObject private var viewModel = AuthenticationViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(uiColor: .systemGray6)
            GatherNaviBar {
                VStack(alignment: .leading) {
                    Button {
                        showingAlert = true
                    } label: {
                        Image(systemName: "person.crop.circle.fill")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 30, height: 30)
                            .alert("회원정보 설정", isPresented: $showingAlert) {
                                profileButtonLayer
                            }
                    }
                }
            } center: {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
            } right: {
                Button {
                    rightButtonAction()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.black)
                        .frame(width: 25, height: 25)
                }
                .isEmpty(logicalOperator: .none, [type == .club])
            }
            .padding(.horizontal, 10)
            .padding(.bottom)
            
            Path { path in
                path.move(to: CGPoint(x: 0, y: UIScreen.getHeightby(ratio: 1 / 7)))
                path.addLine(to: CGPoint(x: UIScreen.screenWidth, y: UIScreen.getHeightby(ratio: 1 / 7)))
            }
            .stroke(style: StrokeStyle(lineWidth: 1))
            .foregroundColor(.init(uiColor: .systemGray4))
        }
        .frame(width: UIScreen.screenWidth,height: UIScreen.getHeightby(ratio: 1 / 7))
        
    }
}

// MARK: SubViews

extension HeaderView {
    private var profileButtonLayer: some View {
        VStack {
            Button("로그아웃") {
                viewModel.signOut(authenticator: authenticator)
            }
            Button("회원탈퇴") {
                viewModel.deleteUser(authenticator: authenticator)
            }
            Button("취소", role: .cancel) {}
        }
    }
}

// MARK: - HeaderView_Previews

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "활동",type: .activity) {
            print("")
        }
    }
}
