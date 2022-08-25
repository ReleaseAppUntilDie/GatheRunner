//
//  FloatingView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/12.
//

import SwiftUI

// MARK: - FloatingView

struct FloatingView: View {

    // MARK: - 측정화면으로 이동을 위한 임시 구현

    @State var tag:Int? = nil

    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .center, spacing: 30) {
                Button { } label: {
                    Image(systemName: "gearshape.fill")
                        .frame(width: UIScreen.main.bounds.width * 0.1154, height: UIScreen.main.bounds.height * 0.0592)
                        .font(.system(size: 25)).foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(200)
                        .shadow(color: Color.gray, radius: 2, x: 3, y: 3)
                }
                ZStack {
                    
                    // MARK: - 측정화면으로 이동을 위한 임시 구현

                    NavigationLink(
                        destination: MeasurementView().environmentObject(LocationManager()),
                        tag: 1,
                        selection: self.$tag)
                    {
                        EmptyView()
                    }
                    Button("시작") {
                        self.tag = 1
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.2820, height: UIScreen.main.bounds.height * 0.1303)
                    .background(Color.yellow)
                    .font(.system(size: 27, weight: .black)).foregroundColor(Color.black)
                    .cornerRadius(200)
                    .accessibilityIdentifier("runStartButton")
                }

                Button { } label: {
                    Image(systemName: "music.note")
                        .frame(width: UIScreen.main.bounds.width * 0.1154, height: UIScreen.main.bounds.height * 0.0592)
                        .font(.system(size: 25)).foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(200)
                        .shadow(color: Color.gray, radius: 2, x: 3, y: 3)
                }
            }

            Button("목표 설정") {
                withAnimation { }
            }
            .frame(width: UIScreen.main.bounds.width * 0.26, height: UIScreen.main.bounds.height * 0.07)
            .font(.system(size: 17, weight: .medium)).foregroundColor(Color.black)
            .background(Color.red)
            .cornerRadius(50)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10))
            .shadow(color: Color.gray, radius: 2, x: 3, y: 3)
        }
    }
}

// MARK: - FloatingView_Previews

struct FloatingView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingView()
    }
}
