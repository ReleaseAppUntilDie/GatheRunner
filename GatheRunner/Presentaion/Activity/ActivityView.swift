//
//  ActivityView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/06/29.
//
import SwiftUI

// MARK: - ActivityView

struct ActivityView: View {



    var body: some View {
        VStack {
            HeaderView(title: "활동",type: .activity) {
                // TODO: 활동 추가
                print("test")
            }
            ActivityHistoryView()
        }
    }
}

// MARK: - ActivityView_Previews

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
