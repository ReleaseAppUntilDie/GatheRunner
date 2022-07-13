//
//  RunningGuideItem.swift
//  GatheRunner
//
//  Created by cho on 2022/07/10.
//

import SwiftUI

struct RunningGuideItem: View {
    // 관리자(개발자) 실수로 runningGuide Item의 내용을 담은 항목(배열)을 삭제할경우 런타임 에러가 발생하는 것을 막기 위해
    // runningGuider.isEmpty 일때 하나의 RunningGuide 타입 항목을 임으로 대입한다. 비어 있지 않으면 runningGuide[0] 항목 대입.
    var runningGuideArrs: RunningGuide = returnRunningGuideArrs().isEmpty ?  RunningGuide(image: "runningGuide_01", title: "러닝 가이드 체험하기", subtitle: "First\nSpeed Run", text: "25분 운동 스피드 런") : returnRunningGuideArrs()[0]

    var body: some View {
        HStack(alignment: .center, spacing: 8.0) {
            Image(runningGuideArrs.image)
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .padding(15)
                    
            VStack(alignment: .leading, spacing: 5.0) {
                Text(runningGuideArrs.title)
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color.gray)
                    .lineLimit(1)
                
                Text(runningGuideArrs.subtitle)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                
                Text(runningGuideArrs.text)
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color.gray)
                    .lineLimit(1)
                
            }.frame(width: 150, height: 100, alignment: .leading)
        }.frame(width: 310, height: 100, alignment: .leading)
            .background(.ultraThickMaterial, in:
                            RoundedRectangle(cornerRadius: 10, style: .continuous))

    }
}

struct RunningGuideItem_Previews: PreviewProvider {
    static var previews: some View {
        RunningGuideItem()
    }
}
