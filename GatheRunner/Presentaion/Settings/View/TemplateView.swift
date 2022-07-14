//
//  TemplateView.swift
//  GatheRunner
//
//  Created by Atlas on 2022/07/12.
//

import SwiftUI

struct TemplateView: View {
    var settingData: SettingModel
    var body: some View {
        HStack {
            Spacer()
            VStack (){
                Image(systemName: settingData.imageIconName)
                    .frame(width: 30 , height: 30, alignment: .center)
                Text(settingData.status)
                    .foregroundColor(Color.gray)
                Text(settingData.description)
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
        self.settingData = SettingModel(type: type)
    }
}


struct TemplateView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateView(type: .indoorOutdoor())
    }
}
