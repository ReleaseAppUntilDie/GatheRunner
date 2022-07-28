//
//  TemplateView.swift
//  GatheRunner
//
//  Created by Atlas on 2022/07/12.
//

import SwiftUI

struct TemplateView: View {
    var model: SettingModel
    typealias SettingType = SettingModel.SettingType
    
    var body: some View {
        HStack {
            Spacer()
            VStack() {
                Image(systemName: model.imageIconName).frame(width: 30, height: 30, alignment: .center)
                Text(model.status).foregroundColor(Color.gray)
                Text(model.description).foregroundColor(Color.black)
            }
            Spacer()
            
        }
        .background(Color.white)
        .onTapGesture { print("Pressed") } //TODO: 구현 예정
        
    }
    
    init(type: SettingType){
        self.model = SettingModel(type)
    }
}


struct TemplateView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateView(type: .audioFeedback)
    }
}
