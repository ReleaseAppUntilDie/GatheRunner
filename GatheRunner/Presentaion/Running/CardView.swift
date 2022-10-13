//
//  CardView.swift
//  GatheRunner
//
//  Created by cho on 2022/10/13.
//

import SwiftUI

struct CardView: View {
    @State private var selectedCardItem: RunGuideItem? = nil
    private let runGuideCardItemArrs = RunGuideViewModel().getArrsRunGuideExperienceItem
    
    var body: some View {
        ForEach(runGuideCardItemArrs) { item in
            ZStack(alignment: .center) {
                cardImage(item)
                VStack(alignment: .center) {
                    cardText(item)
                }
                .cornerRadius(Size.cardItemCornerRadiusValue)
            }
            .frame(width: UIScreen.getWidthby(ratio: Size.cardItemFrameSizeRatio))
            .padding(.bottom, 20)
            .onTapGesture {
                withAnimation {
                    selectedCardItem = item
                }
            }
            .fullScreenCover(item: $selectedCardItem) { item in
                FullScreenCoverView(item: item)
            }
        }
    }

    private func cardImage(_ item: RunGuideItem) -> some View {
        Image(item.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(Size.cardItemCornerRadiusValue)
            .shadow(radius: 2)
    }
    
    @ViewBuilder
    private func cardText(_ item: RunGuideItem) -> some View {
        Text(item.title)
            .font(.largeTitle)
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
        Text(item.subtitle)
            .font(.title2)
            .fontWeight(.medium)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
    }
}

extension CardView {
    private enum Size {
        static let cardItemFrameSizeRatio = 0.89
        static let cardItemCornerRadiusValue: CGFloat = 20
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
