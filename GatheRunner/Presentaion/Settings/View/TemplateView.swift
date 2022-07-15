//
//  TemplateView.swift
//  GatheRunner
//
//  Created by Atlas on 2022/07/12.
//

import SwiftUI

struct TemplateView: View {
    var settingModel: SettingModel
    var body: some View {
        HStack {
            Spacer()
            VStack (){
                Image(systemName: settingModel.imageIconName)
                    .frame(width: 30 , height: 30, alignment: .center)
                Text(settingModel.status)
                    .foregroundColor(Color.gray)
                Text(settingModel.description)
                    .foregroundColor(Color.black)
            }
            Spacer()
        }
        .background(Color.white)
        .onTapGesture {
            print("Pressed")
        }
    }
    
    init(type: ViewType){
        self.settingModel = SettingModel(type)
    }
}


struct TemplateView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateView(type: .audioFeedback)
    }
}
