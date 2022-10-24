//
//  CardView.swift
//  GatheRunner
//
//  Created by cho on 2022/10/13.
//

import SwiftUI

// MARK: - CardView

struct CardView: View {
    
    // MARK: Internal
    
    var body: some View {
        ForEach(runGuideCardItemArrs) { item in
            ZStack {
                cardItem(item)
            }
            .padding(.vertical, 20)
            .onTapGesture {
                withAnimation {
                    selectedCardItem = item
                }
            }
            .fullScreenCover(item: $selectedCardItem) { item in
                RunGuideDetailDescriptionView(selectedItem: $selectedCardItem, item: item)
            }
        }
    }
    
    // MARK: Private
    
    @State private var selectedCardItem: RunGuideItem? = nil
    private let runGuideCardItemArrs = RunGuideViewModel().getArrsRunGuideExperienceItem
}

extension CardView {
    @ViewBuilder
    private func cardItem(_ item: RunGuideItem) -> some View {
        ZStack(alignment: .bottomLeading) {
            Image(item.image)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.getWidthby(ratio: Size.cardItemFrameSizeRatio))
                .overlay {
                    LinearGradient(colors: [.clear, .black.opacity(0.9)], startPoint: .center, endPoint: .bottom)
                }
                .cornerRadius(Size.cardItemCornerRadiusValue)
            cardText(item).padding([.leading, .bottom])
        }
    }

    @ViewBuilder
    private func cardText(_ item: RunGuideItem) -> some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            Text(item.subtitle)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
    }
}

extension CardView {
    private enum Size {
        static let cardItemFrameSizeRatio = 0.89
        static let cardItemCornerRadiusValue: CGFloat = 10
    }
}

// MARK: - CardView_Previews

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
