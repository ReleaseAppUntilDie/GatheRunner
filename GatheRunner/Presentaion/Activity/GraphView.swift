//
//  GraphView.swift
//  GatheRunner
//
//  Created by jaeseung han on 2022/07/29.
//

import SwiftUI

fileprivate enum TimeUnit {
    case week,month,year,whole
}

struct GraphView: View {
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: UIScreen.getHeightby(ratio: 0.02))
                    .strokeBorder(Color(uiColor: .systemGray4),lineWidth: 2)
                    .frame(width: UIScreen.getWidthby(ratio: 0.8), height: UIScreen.getHeightby(ratio: 0.04))
                HStack{
                    Component(isSelected: .constant(true), title: "주")
                    Component(isSelected: .constant(false), title: "월")
                    Component(isSelected: .constant(false), title: "년")
                    Component(isSelected: .constant(false), title: "전체")
                }
                .frame(width: UIScreen.getWidthby(ratio: 0.8), height: UIScreen.getHeightby(ratio: 0.04))
                .onTouch(type: .started) { point in
                    print(point)
                }
                
            }
        }
    }
    
    @ViewBuilder fileprivate func makeSeletedItem(timeUnit : TimeUnit) -> some View{
        let offset : CGFloat = {
            switch timeUnit {
            case .week: return -UIScreen.getWidthby(ratio: 0.30)
            case .month: return -UIScreen.getWidthby(ratio: 0.10)
            case .year: return UIScreen.getWidthby(ratio: 0.10)
            case .whole: return UIScreen.getWidthby(ratio: 0.30)
            }
        }()
        
        RoundedRectangle(cornerRadius: UIScreen.getHeightby(ratio: 0.02))
            .fill(Color.green)
            .frame(width: UIScreen.getWidthby(ratio: 0.20), height: UIScreen.getHeightby(ratio: 0.04))
            .offset(x: offset)
    }
    struct Component : View {
        @Binding var isSelected : Bool
        let title : String
        var body : some View {
            ZStack {
                if isSelected {
                    RoundedRectangle(cornerRadius: UIScreen.getHeightby(ratio: 0.02))
                        .fill(Color.green)
                        .frame(width: UIScreen.getWidthby(ratio: 0.20), height: UIScreen.getHeightby(ratio: 0.04))
                }
                Text(title)
                    .foregroundColor(isSelected ? .black : .init(uiColor: .systemGray2))
                    .frame(width: UIScreen.getWidthby(ratio: 0.20))
            }
        }
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}


