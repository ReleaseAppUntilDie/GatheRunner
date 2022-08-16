//
//  RunningGuideViewModel.swift
//  GatheRunner
//
//  Created by cho on 2022/07/16.
//

import SwiftUI

class RunningGuideViewModel: ObservableObject {

    // MARK: Internal


    var getRunningGuideArrs: [RunningGuide] {
        runningGuide
    }

    // MARK: Private

    // MARK: 서버 API 미구현 상태 -> 임시로 선언한 더미 데이터 -> API 구현 후 해당 코드 변경 예정
    private var runningGuide = [
        RunningGuide(image: "runningGuide_01", title: "러닝 가이드 체험하기", subtitle: "First\nSpeed Run", text: "25분 운동 스피드 런", tag: 0),
        RunningGuide(image: "runningGuide_02", title: "러닝 가이드 체험하기", subtitle: "Next Run", text: "24분 운동 회복 러닝", tag: 1),
        RunningGuide(image: "runningGuide_03", title: "러닝 가이드 체험하기", subtitle: "First Run", text: "23분 운동 회복 러닝", tag: 2),
        RunningGuide(image: "runningGuide_04", title: "러닝 가이드 체험하기", subtitle: "First Long Run", text: "35분 운동 장거리 러닝", tag: 3),
        RunningGuide(
            image: "runningGuide_05",
            title: "러닝 가이드 체험하기",
            subtitle: "First Treadmill Run",
            text: "24분 운동 Treadmill Run",
            tag: 4),
        RunningGuide(image: "runningGuide_06", title: "", subtitle: "NRC 크루들과 함께하는 러닝 가이드 더 보기", text: "", tag: 5),
    ]
}
