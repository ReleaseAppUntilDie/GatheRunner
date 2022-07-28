//
//  SettingView.swift
//  GatheRunner
//
//  Created by Atlas on 2022/07/07.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                MeasurementView()
                DetailControllView()
                
                //MARK: - TEST CODE
                
                Button("Dismiss button for testing") { dismiss() }
                .padding(10)
                .background(Color.mint)
                .frame(height: 30, alignment: .center)
                
                Spacer()
            }
        }
    }
    
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
