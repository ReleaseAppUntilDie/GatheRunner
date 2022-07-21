//
//  RunningGuideItem.swift
//  GatheRunner
//
//  Created by cho on 2022/07/10.
//

import SwiftUI

struct RunningGuideTabItem: View {
    private var runningGuideArrs = RunningGuideViewModel().getRunningGuideArrs
    
    var body: some View {
        ForEach(runningGuideArrs.indices, id: \.self) { index in
            HStack(alignment: .center, spacing: 8.0) {
                Image(runningGuideArrs[index].image)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.28, height: UIScreen.main.bounds.height * 0.14)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 5))
                VStack(alignment: .leading, spacing: 5.0) {
                    Text(runningGuideArrs[index].title)
                        .font(.system(size: 15))
                        .fontWeight(.regular)
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                    Text(runningGuideArrs[index].subtitle)
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    Text(runningGuideArrs[index].text)
                        .font(.system(size: 15))
                        .fontWeight(.regular)
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                }.frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.height * 0.14, alignment: .leading)
            }.frame(width: UIScreen.main.bounds.width * 0.82, height: UIScreen.main.bounds.height * 0.13, alignment: .leading)
                .background(.ultraThickMaterial, in:
                                RoundedRectangle(cornerRadius: 15, style: .continuous))
        }
    }
}

struct RunningGuideItem_Previews: PreviewProvider {
    static var previews: some View {
        RunningGuideTabItem()
    }
}
