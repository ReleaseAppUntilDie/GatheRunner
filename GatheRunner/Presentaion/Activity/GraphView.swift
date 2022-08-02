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
    @State private var weekSelect = true
    @State private var monthSelect = false
    @State private var yearSelect = false
    @State private var wholeSelect = false
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: UIScreen.getHeightby(ratio: 0.02))
                    .strokeBorder(Color(uiColor: .systemGray4),lineWidth: 2)
                    .frame(width: UIScreen.getWidthby(ratio: 0.8), height: UIScreen.getHeightby(ratio: 0.04))
              
                HStack(alignment: .verticalCustom){
                    Component(isSelected: $weekSelect, title: "주")
                    Component(isSelected: $monthSelect, title: "월")
                    Component(isSelected: $yearSelect, title: "년")
                    Component(isSelected: $wholeSelect, title: "전체")
                }
                .frame(width: UIScreen.getWidthby(ratio: 0.8), height: UIScreen.getHeightby(ratio: 0.04))
                .onTouch(type: .started) { point in
                    
                    if point.x < UIScreen.getWidthby(ratio: 0.2) {
                        weekSelect = true
                        monthSelect = false
                        yearSelect = false
                        wholeSelect = false
                        print("주")
                    } else if point.x >= UIScreen.getWidthby(ratio: 0.2) && point.x < UIScreen.getWidthby(ratio: 0.4) {
                        weekSelect = false
                        monthSelect = true
                        yearSelect = false
                        wholeSelect = false
                        print("월")
                    } else if point.x >= UIScreen.getWidthby(ratio: 0.4) && point.x < UIScreen.getWidthby(ratio: 0.6) {
                        weekSelect = false
                        monthSelect = false
                        yearSelect = true
                        wholeSelect = false
                        print("년")
                    } else if point.x >= UIScreen.getWidthby(ratio: 0.6) {
                        weekSelect = false
                        monthSelect = false
                        yearSelect = false
                        wholeSelect = true
                        print("전체")
                    }
                    
                }
            }
        }
    }
    
    
    struct Component : View {
        @Binding var isSelected : Bool
        let title : String
        var body : some View {
            ZStack(alignment:.center) {
                if isSelected {
                    RoundedRectangle(cornerRadius: UIScreen.getHeightby(ratio: 0.02))
                        .fill(Color.green)
                        .frame(width: UIScreen.getWidthby(ratio: 0.15), height: UIScreen.getHeightby(ratio: 0.04))
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


