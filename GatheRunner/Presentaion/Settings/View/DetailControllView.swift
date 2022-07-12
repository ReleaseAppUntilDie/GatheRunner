//
//  DetailControllView.swift
//  GatheRunner
//
//  Created by Atlas on 2022/07/12.
//

import SwiftUI

struct DetailControllView: View {
    var body: some View {
        VStack (spacing: 10){
            HStack {
                Spacer()
                Text("측정")
                    .frame(height: 50, alignment: .center)
                Spacer()
            }.background(Color.mint)

            HStack {
                TemplateView(type: .audioFeedback())
                TemplateView(type: .countDown())
            }
            HStack {
                TemplateView(type: .orientation())
                TemplateView(type: .display())
            }
        }
    }
}

struct DetailControllView_Previews: PreviewProvider {
    static var previews: some View {
        DetailControllView()
    }
}
