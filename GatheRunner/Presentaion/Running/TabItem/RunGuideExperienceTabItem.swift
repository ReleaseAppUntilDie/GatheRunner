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
                tabItemImages(index: index)
                VStack(alignment: .leading, spacing: 5.0) {
                    tabItemTexts(category: .title, index: index).lineLimit(1)
                    tabItemTexts(category: .subtitle, index: index)
                    tabItemTexts(category: .contents, index: index).lineLimit(1)
                }.frame(
                    width: UIScreen.getWidthby(ratio: Size.tabItemTextsVStackFrameWidthRatio),
                    height: UIScreen.getHeightby(ratio: Size.tabItemTextsVStackFrameHeightRatio),
                    alignment: .leading)
            }.frame(
                width: UIScreen.getWidthby(ratio: Size.tabItemTextsHStackFrameWidthRatio),
                height: UIScreen.getHeightby(ratio: Size.tabItemTextsHStackFrameHeightRatio),
                alignment: .leading)
                .background(.ultraThickMaterial, in:
                    RoundedRectangle(cornerRadius: 15, style: .continuous))
        }
    }

    // MARK: Private

    private var arrsRunGuideExperienceTabItem = RunGuideViewModel().getArrsRunGuideExperienceItem
}

extension RunGuideExperienceTabItem {
    private enum Size {
        static let tabItemTextsVStackFrameWidthRatio = 0.45
        static let tabItemTextsVStackFrameHeightRatio = 0.14
        static let tabItemTextsHStackFrameWidthRatio = 0.82
        static let tabItemTextsHStackFrameHeightRatio = 0.13
        static let tabItemImagesFrameWidthRatio = 0.28
        static let tabItemImagesFrameHeightRatio = 0.14
    }

    private enum ItemCategory {
        case title
        case subtitle
        case contents
    }
}

extension RunGuideExperienceTabItem {
    private func tabItemImages(index: Int) -> some View {
        Image(arrsRunGuideExperienceTabItem[index].image)
            .resizable(resizingMode: .stretch)
            .aspectRatio(contentMode: .fit)
            .frame(
                width: UIScreen.getWidthby(ratio: Size.tabItemImagesFrameWidthRatio),
                height: UIScreen.getHeightby(ratio: Size.tabItemImagesFrameHeightRatio))
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 5))
    }

    private func tabItemTexts(category: ItemCategory, index: Int) -> some View {
        Text(selectCategory(category, idx: index))
            .font(.system(size: 15))
            .fontWeight(.regular)
            .foregroundColor(Color.gray)
    }
}

extension RunGuideExperienceTabItem {
    private func selectCategory(_ s: ItemCategory, idx index: Int) -> String {
        switch s {
        case .title: return arrsRunGuideExperienceTabItem[index].title
        case .subtitle: return arrsRunGuideExperienceTabItem[index].subtitle
        case .contents: return arrsRunGuideExperienceTabItem[index].contents
        }
    }
}

// MARK: - RunGuideExperienceTabItem_Previews

struct RunGuideExperienceTabItem_Previews: PreviewProvider {
    static var previews: some View {
        RunGuideExperienceTabItem()
    }
}
