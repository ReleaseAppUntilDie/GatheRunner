//
//  TemplateView.swift
//  GatheRunner
//
//  Created by Atlas on 2022/07/12.
//

import SwiftUI

// MARK: - TemplateView

struct TemplateView: View {

    // MARK: Lifecycle


    init(type: ViewType) {
        model = SettingModel(type)
    }

    // MARK: Internal

    var model: SettingModel

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Image(systemName: model.imageIconName)
                    .frame(width: 30 , height: 30, alignment: .center)
                Text(model.status)
                    .foregroundColor(Color.gray)
                Text(model.description)
                    .foregroundColor(Color.black)
            }
            Spacer()
        }
        .background(Color.white)
        .onTapGesture {
            print("Pressed")
        }
    }
}


// MARK: - TemplateView_Previews

struct TemplateView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateView(type: .audioFeedback)
    }
}
