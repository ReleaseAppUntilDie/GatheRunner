//
//  TemplateView.swift
//  GatheRunner
//
//  Created by Atlas on 2022/07/12.
//

import SwiftUI

struct TemplateView: View {
    var viewModel: ViewModel
    var body: some View {
        HStack {
            Spacer()
            VStack (){
                Image(systemName: viewModel.imageIconName)
                    .frame(width: 30 , height: 30, alignment: .center)
                Text(viewModel.status)
                    .foregroundColor(Color.gray)
                Text(viewModel.description)
                    .foregroundColor(Color.black)
            }
            Spacer()
        }
        .background(Color.white)
        .onTapGesture {
            print("Pressed")
        }
    }
    
    init(type: SettingType){
        self.viewModel = ViewModel(type: type)
    }
}


struct TemplateView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateView(type: .indoorOutdoor())
    }
}
