//
//  RunningGuideItem.swift
//  GatheRunner
//
//  Created by cho on 2022/07/10.
//

import SwiftUI

struct RunningGuideItem: View {
    var runningGuideArrs: RunningGuide = runningGuide[0]
    
    var body: some View {
        HStack(alignment: .center, spacing: 8.0) {
            Image(runningGuideArrs.image)
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .padding(15)
                    
            VStack(alignment: .leading, spacing: 5.0) {
                Text(runningGuideArrs.title)
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color.gray)
                    .lineLimit(1)
                
                Text(runningGuideArrs.subtitle)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                
                Text(runningGuideArrs.text)
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color.gray)
                    .lineLimit(1)
                
            }.frame(width: 150, height: 100, alignment: .leading)
//                .border(Color.green, width: 2)
        }.frame(width: 310, height: 100, alignment: .leading)
//            .border(Color.red, width: 2)
            .background(.ultraThickMaterial, in:
                            RoundedRectangle(cornerRadius: 10, style: .continuous))

    }
}

struct RunningGuideItem_Previews: PreviewProvider {
    static var previews: some View {
        RunningGuideItem()
    }
}
