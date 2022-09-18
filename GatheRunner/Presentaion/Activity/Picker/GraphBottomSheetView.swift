//
//  BottomSheetView.swift
//  GatheRunner
//
//  Created by 김현진 on 2022/09/18.
//

import SwiftUI

// MARK: - GraphBottomSheetView

struct GraphBottomSheetView: View {

    @ObservedObject var viewModel: GraphViewModel
    var pickerItems = ["이번주","저번주","어제","오늘"]
    @State var selected = ""
    @Binding var show: Bool
    @Binding var selectedTimeUnit: TimeUnit

    var body: some View {
        ZStack(alignment:.bottom) {
            Color.black.opacity(show ? 0.5 : 0)
                .edgesIgnoringSafeArea(.top)
                .onTapGesture {
                    withAnimation(.linear) {
                        show.toggle()
                    }
                }

            VStack {
                Picker("Choose period", selection: $selected) {
                    ForEach(viewModel.pickerItemList,id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.wheel)
                .padding()
                Button {
                    withAnimation(.linear) {
                        show.toggle()
                    }
                } label: {
                    Text("선택")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.getWidthby(ratio: 0.8), height: 50, alignment: .center)

                        .background(RoundedRectangle(cornerRadius: 25).fill(Color.black))
                }
            }
            .frame(width: UIScreen.screenWidth)
            .frame(maxHeight: show ? UIScreen.getHeightby(ratio: 0.5) : 0)
            .background(Color.white)
            .cornerRadius(16, corners: [.topLeft,.topRight])
        }
    }
}

// MARK: - BottomSheetView_Previews

// struct BottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        GraphBottomSheetView(show: .constant(true),selectedTimeUnit: .constant(.week))
//    }
// }
