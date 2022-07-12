//
//  RunningView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI

struct RunningView: View {
    @State var justStartButtonIsSelected: Bool = true
    @State var runningGuideButtonIsSelected: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text("Header View")
                }
                .frame(maxWidth: .infinity, maxHeight: 120)
    //                .border(Color.red, width: 2)
                
                HStack {
                    Button("바로 시작") {
                        withAnimation {
                            if !justStartButtonIsSelected && runningGuideButtonIsSelected {
                                justStartButtonIsSelected.toggle()
                                runningGuideButtonIsSelected.toggle()
                            }
                        }
                    }
                    .frame(width: 100, height: 10)
                    .foregroundColor(justStartButtonIsSelected ? Color.black : Color.gray)
                    .padding(4)
     
                    
                    Button("러닝 가이드") {
                        withAnimation {
                            if justStartButtonIsSelected && !runningGuideButtonIsSelected {
                                runningGuideButtonIsSelected.toggle()
                                justStartButtonIsSelected.toggle()
                            }
                        }
                    }.foregroundColor(runningGuideButtonIsSelected ? Color.black : Color.gray)
                }
                .zIndex(1)
                .frame(width: 400, height: 30, alignment: .leading)
                    .font(Font.system(size: 14))

                
                VStack {
                    if justStartButtonIsSelected {
                        JustStartView()
                            .transition(.move(edge: .leading))
                    }
                    
                    if runningGuideButtonIsSelected {
                        RunningGuideView()
                            .transition(.move(edge: .trailing))
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//                    .border(Color.blue, width: 8)
                

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    //            .border(Color.pink, width: 4)
                .ignoresSafeArea(edges: .top)
        }
    }
}

struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView()
    }
}
