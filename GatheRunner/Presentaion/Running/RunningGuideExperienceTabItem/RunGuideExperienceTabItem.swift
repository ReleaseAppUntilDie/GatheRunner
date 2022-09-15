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
                TabItemImages(index: index)
                VStack(alignment: .leading, spacing: 5.0) {
                    TabItemTexts(itemCategory: .title, index: index).lineLimit(1)
                    TabItemTexts(itemCategory: .subtitle, index: index)
                    TabItemTexts(itemCategory: .text, index: index).lineLimit(1)
                }.frame(
                    width: UIScreen.getWidthby(ratio: vStackFrameWidthRatio),
                    height: UIScreen.getHeightby(ratio: vStackFrameHeightRatio),
                    alignment: .leading)
            }.frame(
                width: UIScreen.getWidthby(ratio: hStackFrameWidthRatio),
                height: UIScreen.getHeightby(ratio: hStackFrameHeightRatio),
                alignment: .leading)
                .background(
                    .ultraThickMaterial,
                    in:
                    RoundedRectangle(cornerRadius: 15, style: .continuous))
        }
    }

    // MARK: Private

    private let vStackFrameWidthRatio = 0.45
    private let vStackFrameHeightRatio = 0.14
    private let hStackFrameWidthRatio = 0.82
    private let hStackFrameHeightRatio = 0.13

    private var arrsRunGuideExperienceTabItem = RunGuideExperienceVM().getArrsRunGuideExperienceItem
}

// MARK: - TabItemImages

struct TabItemImages: View {
    private let imageFrameWidthRatio = 0.28
    private let imageFrameHeightRatio = 0.14

    fileprivate var arrsRunGuideExperienceTabItem = RunGuideExperienceVM().getArrsRunGuideExperienceItem
    fileprivate let index: Int

    var body: some View {
        Image(arrsRunGuideExperienceTabItem[index].image)
            .resizable(resizingMode: .stretch)
            .aspectRatio(contentMode: .fit)
            .frame(
                width: UIScreen.getWidthby(ratio: imageFrameWidthRatio),
                height: UIScreen.getHeightby(ratio: imageFrameHeightRatio))
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 5))
    }
}

// MARK: - TabItemTexts

struct TabItemTexts: View {
    private let arrsRunGuideExperienceTabItem = RunGuideExperienceVM().getArrsRunGuideExperienceItem
    fileprivate var itemCategory: ItemCategory
    fileprivate let index: Int

    var body: some View {
        Text(selectCategory(itemCategory, idx: index))
            .font(.system(size: 15))
            .fontWeight(.regular)
            .foregroundColor(Color.gray)
    }

    private func selectCategory(_ s: ItemCategory, idx index: Int) -> String {
        switch s {
        case .title: return arrsRunGuideExperienceTabItem[index].title
        case .subtitle: return arrsRunGuideExperienceTabItem[index].subtitle
        case .text: return arrsRunGuideExperienceTabItem[index].text
        }
    }
}

extension TabItemTexts {
    enum ItemCategory {
        case title
        case subtitle
        case text
    }
}

// MARK: - RunGuideExperienceTabItem_Previews

struct RunGuideExperienceTabItem_Previews: PreviewProvider {
    static var previews: some View {
        RunGuideExperienceTabItem()
    }
}
