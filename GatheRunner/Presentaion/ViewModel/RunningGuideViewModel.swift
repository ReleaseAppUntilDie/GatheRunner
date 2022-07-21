//
//  RunningGuideViewModel.swift
//  GatheRunner
//
//  Created by cho on 2022/07/16.
//

import SwiftUI

class RunningGuideViewModel: ObservableObject {
    private var runningGuide = [
        RunningGuide(image: "runningGuide_01", title: "러닝 가이드 체험하기", subtitle: "First\nSpeed Run", text: "25분 운동 스피드 런"),
        RunningGuide(image: "runningGuide_02", title: "러닝 가이드 체험하기", subtitle: "Next Run", text: "24분 운동 회복 러닝"),
        RunningGuide(image: "runningGuide_03", title: "러닝 가이드 체험하기", subtitle: "First Run", text: "23분 운동 회복 러닝"),
        RunningGuide(image: "runningGuide_04", title: "러닝 가이드 체험하기", subtitle: "First Long Run", text: "35분 운동 장거리 러닝"),
        RunningGuide(image: "runningGuide_05", title: "러닝 가이드 체험하기", subtitle: "First Treadmill Run", text: "24분 운동 Treadmill Run"),
        RunningGuide(image: "runningGuide_06", title: "", subtitle: "NRC 크루들과 함께하는 러닝 가이드 더 보기", text: "")
    ]
    
    func getRunningGuideArrs() -> [RunningGuide] {
        if runningGuide[safe: 0] == nil {
            runningGuide = [RunningGuide(image: "runningGuide_01", title: "러닝 가이드 체험하기", subtitle: "First\nSpeed Run", text: "25분 운동 스피드 런")]
        }
        return runningGuide
    }
}

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
