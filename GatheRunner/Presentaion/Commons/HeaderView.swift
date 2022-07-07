//
//  HeaderView.swift
//  GatheRunner
//
//  Created by jaeseung han on 2022/07/07.
//

import SwiftUI

struct HeaderView: View {
    let title : String
    
    var body: some View {
        ZStack(alignment:.bottom){
            Color(uiColor: .systemGray6)
            HStack(alignment: .center){
                Button {
                    //TODO: profile view로 이동
                    print("move to profile")
                } label: {
                    Image(systemName: "person.crop.circle.fill")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: ScreenSize.getWidth(30), height: ScreenSize.getWidth(30))
                }

                
                Spacer()
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                Spacer()
                Button {
                    //TODO: 활동 추가 기능
                    print("활동추가")
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.black)
                        .frame(width: ScreenSize.getWidth(25), height: ScreenSize.getWidth(25))
                }

            }.padding(.horizontal,10)
                .padding(.bottom)
            Path { path in
                path.move(to: CGPoint(x: 0, y: ScreenSize.getHeightby(ratio: 1/7)))
                path.addLine(to: CGPoint(x: ScreenSize.screenWidth, y: ScreenSize.getHeightby(ratio: 1/7)))
            }
            .stroke(style: StrokeStyle(lineWidth:1))
            .foregroundColor(.init(uiColor: .systemGray4))

        }.frame(width: ScreenSize.screenWidth,height: ScreenSize.getHeightby(ratio: 1/7))
            .ignoresSafeArea()
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title:"활동")
    }
}
