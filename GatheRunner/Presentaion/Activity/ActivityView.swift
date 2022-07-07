//
//  ActivityView.swift
//  GatheRunner
//
//  Created by 김동현 on 2022/06/29.
//

import SwiftUI

struct ActivityView: View {
    var body: some View {
        VStack{
            HeaderView(title: "활동")
            Spacer()
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
