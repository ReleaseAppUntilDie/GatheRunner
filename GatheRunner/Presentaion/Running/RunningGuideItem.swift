//
//  RunningGuideItem.swift
//  GatheRunner
//
//  Created by cho on 2022/07/10.
//

import SwiftUI

struct RunningGuideItem: View {
    private var runningGuideArrs = RunningGuideViewModel()
    
    var body: some View {
        ForEach(runningGuideArrs.getRunningGuideArrs()) { item in
            HStack(alignment: .center, spacing: 8.0) {
                Image(item.image)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .padding(15)
                
                VStack(alignment: .leading, spacing: 5.0) {
                    Text(item.title)
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                    
                    Text(item.subtitle)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    
                    Text(item.text)
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                    
                }.frame(width: 150, height: 100, alignment: .leading)
            }.frame(width: 310, height: 100, alignment: .leading)
                .background(.ultraThickMaterial, in:
                                RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
        
    }
}

struct RunningGuideItem_Previews: PreviewProvider {
    static var previews: some View {
        RunningGuideItem()
    }
}
