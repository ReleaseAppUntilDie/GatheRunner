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
                TempletView(type: .indoorOutdoor())
                TempletView(type: .autoPause())
            }
        }
    }
}

struct DetailControllView: View {
    var body: some View {
        VStack {
            Text("표시 및 음성")
            HStack {
                TempletView(type: .audioFeedback())
                TempletView(type: .countDown())
            }
            HStack {
                TempletView(type: .orientation())
                TempletView(type: .display())
            }
        }
    }
}

struct TempletView: View {
//    @State var type: SettingType
    var viewModel: ViewModel
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Image(systemName: viewModel.imageIconName)
                Text(viewModel.status)
                Text(viewModel.description)
            }
            Spacer()
        }.onTapGesture {
            print("Pressed")
        }
    }
    
    init(type: SettingType){
        self.viewModel = ViewModel(type: type)
    }
}

enum SettingType {
    case indoorOutdoor(status: String = "Outdoor", description: String = "Indoor/Outdoor", icon:String = "person.icloud.fill", alignment: Alignment = .center , iconImageHidden: Bool = false, statusTextHidden:Bool = false, descriptionTextHidden: Bool = false)
    case autoPause(status: String = "On", description: String = "Auto-Pause", icon:String = "person.icloud.fill", alignment: Alignment = .center , iconImageHidden: Bool = false, statusTextHidden:Bool = false, descriptionTextHidden: Bool = false)
    case audioFeedback(status: String = "Portrait", description: String = "On/Female", icon:String = "person.icloud.fill", alignment: Alignment = .center , iconImageHidden: Bool = false, statusTextHidden:Bool = false, descriptionTextHidden: Bool = false)
    case countDown(status: String = "3 Seconds", description: String = "Countdown", icon:String = "person.icloud.fill", alignment: Alignment = .center , iconImageHidden: Bool = false, statusTextHidden:Bool = false, descriptionTextHidden: Bool = false)
    case orientation(status: String = "Portrait", description: String = "Orientation", icon:String = "person.icloud.fill", alignment: Alignment = .center , iconImageHidden: Bool = false, statusTextHidden:Bool = false, descriptionTextHidden: Bool = false)
    case display(status: String = "Run Level Color", description: String = "Display", icon:String = "person.icloud.fill", alignment: Alignment = .center , iconImageHidden: Bool = false, statusTextHidden:Bool = false, descriptionTextHidden: Bool = false)
}

extension TempletView {
    class ViewModel {
        
        var status: String
        var description: String
        var imageIconName: String
        var alignment: Alignment
        var iconImageHidden: Bool
        var statusTextHidden: Bool
        var descriptionTextHidden: Bool
        
        init(type: SettingType){
            switch type {
            case .indoorOutdoor(let status, let description, let icon, let alignment, let iconImageHidden, let statusTextHidden, let descriptionTextHidden):
                self.status = status
                self.description = description
                self.imageIconName = icon
                self.alignment = alignment
                self.iconImageHidden = iconImageHidden
                self.statusTextHidden = statusTextHidden
                self.descriptionTextHidden = descriptionTextHidden
            case .autoPause(let status, let description, let icon, let alignment, let iconImageHidden, let statusTextHidden, let descriptionTextHidden):
                self.status = status
                self.description = description
                self.imageIconName = icon
                self.alignment = alignment
                self.iconImageHidden = iconImageHidden
                self.statusTextHidden = statusTextHidden
                self.descriptionTextHidden = descriptionTextHidden
            case .audioFeedback(let status, let description, let icon, let alignment, let iconImageHidden, let statusTextHidden, let descriptionTextHidden):
                self.status = status
                self.description = description
                self.imageIconName = icon
                self.alignment = alignment
                self.iconImageHidden = iconImageHidden
                self.statusTextHidden = statusTextHidden
                self.descriptionTextHidden = descriptionTextHidden
            case .countDown(let status, let description, let icon, let alignment, let iconImageHidden, let statusTextHidden, let descriptionTextHidden):
                self.status = status
                self.description = description
                self.imageIconName = icon
                self.alignment = alignment
                self.iconImageHidden = iconImageHidden
                self.statusTextHidden = statusTextHidden
                self.descriptionTextHidden = descriptionTextHidden
            case .orientation(let status, let description, let icon, let alignment, let iconImageHidden, let statusTextHidden, let descriptionTextHidden):
                self.status = status
                self.description = description
                self.imageIconName = icon
                self.alignment = alignment
                self.iconImageHidden = iconImageHidden
                self.statusTextHidden = statusTextHidden
                self.descriptionTextHidden = descriptionTextHidden
            case .display(let status, let description, let icon, let alignment, let iconImageHidden, let statusTextHidden, let descriptionTextHidden):
                self.status = status
                self.description = description
                self.imageIconName = icon
                self.alignment = alignment
                self.iconImageHidden = iconImageHidden
                self.statusTextHidden = statusTextHidden
                self.descriptionTextHidden = descriptionTextHidden
            }
            
        }
        
        func getStatus() -> String {
            return ""
        }
        
        func getDescription(){
            
        }
        
        func getImageName(){
            
        }
        
    }
}
