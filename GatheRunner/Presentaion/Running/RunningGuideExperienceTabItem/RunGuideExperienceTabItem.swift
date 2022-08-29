//
//  RunGuideExperienceTabItem.swift
//  GatheRunner
//
//  Created by cho on 2022/07/10.
//

import SwiftUI

// MARK: - RunGuideExperienceTabItem

struct RunGuideExperienceTabItem: View {

    // MARK: Internal

    var body: some View {
        ForEach(arrsRunGuideExperienceTabItem.indices, id: \.self) { index in
            HStack(alignment: .center, spacing: 8.0) {
                Image(arrsRunGuideExperienceTabItem[index].image)
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.28, height: UIScreen.main.bounds.height * 0.14)
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 5))

                VStack(alignment: .leading, spacing: 5.0) {
                    Text(arrsRunGuideExperienceTabItem[index].title)
                        .font(.system(size: 15))
                        .fontWeight(.regular)
                        .foregroundColor(Color.gray)
                        .lineLimit(1)

                    Text(arrsRunGuideExperienceTabItem[index].subtitle)
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)

                    Text(arrsRunGuideExperienceTabItem[index].text)
                        .font(.system(size: 15))
                        .fontWeight(.regular)
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                }.frame(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.height * 0.14, alignment: .leading)
            }.frame(width: UIScreen.main.bounds.width * 0.82, height: UIScreen.main.bounds.height * 0.13, alignment: .leading)
                .background(
                    .ultraThickMaterial,
                    in:
                    RoundedRectangle(cornerRadius: 15, style: .continuous))
        }
    }

    // MARK: Private

    private var arrsRunGuideExperienceTabItem = RunGuideExperienceItemVM().getArrsRunGuideExperienceItem
}

// MARK: - RunGuideExperienceTabItem_Previews

struct RunGuideExperienceTabItem_Previews: PreviewProvider {
    static var previews: some View {
        RunGuideExperienceTabItem()
    }
}
