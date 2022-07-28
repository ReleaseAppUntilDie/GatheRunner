//
//  HeaderView.swift
//  GatheRunner
//
//  Created by jaeseung han on 2022/07/07.
//

import SwiftUI

struct HeaderView: View {
    let title : String
    let type : Views
    
    let rightButtonAction: (() -> Void)
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(uiColor: .systemGray6)
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Button { print("move to profile")  //TODO: profile view 이동 구현 예정
                    } label: {
                        Image(systemName: "person.crop.circle.fill")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 30, height: 30)
                    }
                }
                Spacer()
                
                Text(title).font(.system(size: 20, weight: .bold))
                Spacer()
                
                if type == .activity || type == .club {
                    Button { rightButtonAction()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.black)
                            .frame(width: 25, height: 25)
                    }
                }
                
            }
            .padding(.horizontal,10)
            .padding(.bottom)
            
            Path {
                $0.move(to: CGPoint(x: 0, y: UIScreen.getHeightby(ratio: 1/7)))
                $0.addLine(to: CGPoint(x: UIScreen.screenWidth, y: UIScreen.getHeightby(ratio: 1/7)))
            }
            .stroke(style: StrokeStyle(lineWidth: 1))
            .foregroundColor(.init(uiColor: .systemGray4))
            
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.getHeightby(ratio: 1/7))
        .ignoresSafeArea()
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "활동",type: .activity) {
            print("HeaderView Log")
        }
    }
}
