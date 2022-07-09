//
//  SettingView.swift
//  GatheRunner
//
//  Created by Atlas on 2022/07/07.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack{
            MeasurementView()
            DetailControllView()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

struct MeasurementView: View {
    var body: some View {
        VStack {
            Text("측정")
            HStack {
                TempletView()
                TempletView()
            }
        }
    }
}

struct DetailControllView: View {
    var body: some View {
        VStack {
            Text("표시 및 음성")
            HStack {
                TempletView()
                TempletView()
            }
            HStack {
                TempletView()
                TempletView()
            }
        }
    }
}

struct TempletView: View {
    var body: some View {
        Spacer()
        VStack {
            Image(systemName: "person.icloud.fill")
            Text("hi")
            Text("hi2")
        }
        Spacer()
    }
}
