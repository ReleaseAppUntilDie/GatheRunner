//
//  RunningView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI

struct RunningView: View {
    // @State 프로퍼티 래퍼는 Private 형태로 바인딩하여 View 내부에서만 사용할 수 있다.
    // 애플에서는 Toggle 유무와 같이 UI 상태값과 같은 아주 한정된 용도로만 @State 를 사용하길 권장하고 있다. 선언된 뷰 안에서만 사용할 수 있기 때문이다.
    // 만약 뷰 밖의 클래스에서 사용한다면 ObservableObject 프로토콜과 @Published, @ObservedObject 를 사용하면 된다.
    // 만약 두개의 뷰가 동시에 하나의 @State를 참조해야 하는 경우 @Binding 프로퍼티 래퍼를 사용하면 된다.
    @State private var justStartButtonIsSelected: Bool = true
    @State private var runningGuideButtonIsSelected: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Text("Header View")
                    .frame(width: UIScreen.main.bounds.size.width, height: 120)
                    .zIndex(1)
                
                HStack {
                    commonBtn(title: "바로 시작", isToggled: $justStartButtonIsSelected, isOtherToggled: $runningGuideButtonIsSelected)
                        .padding(4)
                    commonBtn(title: "러닝 가이드", isToggled: $runningGuideButtonIsSelected, isOtherToggled: $justStartButtonIsSelected)
                }
                .zIndex(1)
                .frame(width: 400, height: 30, alignment: .leading)
                
                if justStartButtonIsSelected {
                    JustStartView()
                    // 아래와 같이 뷰를 생성할때 transition을 이용한다고 하자 .move(edge: .leading)값으로 호출하면 화면 좌측 끝에서 우측으로 화면 이동효과가 구현되는데, 해당 transition을 한번더 실행할 경우 자동으로 반대 방향(우측->좌측)으로 애니메이션이 구현된다.
                    // 이 경우 if 문을 따로 구현해야 위에서 이야기한 transition 효과를 적용할 수 있다.
                    // if else 로 나누게 되면 뷰가 사라질때 트랜지션 효과가 반대방향으로 적용되지 않는 문제가 있다.
                        .transition(.move(edge: .leading))
                }
                
                if runningGuideButtonIsSelected {
                    RunningGuideView()
                        .transition(.move(edge: .trailing))
                }
                
            }// 화면 전체의 VStack : maxHeight로 초기화 하지 않고 height로 초기화 하게 되면 뷰에 포함된 컨텐츠의 크기가 작아 사이즈가 줄어들때 뷰의 크기도 덩달아 작아지는 문제 있음 -> 따라서 maxHeight를 사용해서 초기화 하는 방법을 사용.
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea(edges: .top)
        }
    }
}

struct commonBtn: View {
    var title: String
    @Binding var isToggled: Bool
    @Binding var isOtherToggled: Bool
    
    var body: some View {
        Button(title) {
            withAnimation {
                if !isToggled {
                    self.isToggled.toggle()
                    self.isOtherToggled.toggle()
                }
            }
        }
        .frame(width: 100, height: 10)
        .foregroundColor(isToggled ? Color.black : Color.gray)
        .font(.system(size: 14))
    }
}


struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView()
    }
}
