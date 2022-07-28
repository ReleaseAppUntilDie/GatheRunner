//
//  FloatingView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/12.
//

import SwiftUI

struct FloatingView: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .center, spacing: 30) {
                Button {
                } label: {
                    Image(systemName: "gearshape.fill")
                        .frame(width: 50, height: 50)
                        .font(Font.system(size: 25)).foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(200)
                }
                
                Button("시작") {}
                .frame(width: 100, height: 100)
                .background(Color.yellow)
                .font(.system(size: 27, weight: .black)).foregroundColor(Color.black)
                .cornerRadius(200)
                
                Button {
                } label: {
                    Image(systemName: "music.note")
                        .frame(width: 50, height: 50)
                        .font(Font.system(size: 25)).foregroundColor(Color.black)
                        .background(Color.white)
                        .cornerRadius(200)
                }
            }
            
            Button("목표 설정") {}
            .frame(width: 100, height: 40)
            .font(Font.system(size: 17, weight: .medium)).foregroundColor(Color.black)
            .background(Color.red)
            .cornerRadius(50)
            .padding(10)
        }
    }
}

struct FloatingView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingView()
    }
}
