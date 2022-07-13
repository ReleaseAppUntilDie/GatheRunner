//
//  RunningGuide.swift
//  GatheRunner
//
//  Created by cho on 2022/07/10.
//

import SwiftUI

struct RunningGuide: Identifiable {
    let id = UUID()
    var image: String
    var title: String
    var subtitle: String
    var text: String
    
}

func returnRunningGuideArrs() -> [RunningGuide] {
    return runningGuide
}

private var runningGuide = [
    RunningGuide(image: "runningGuide_01", title: "러닝 가이드 체험하기", subtitle: "First\nSpeed Run", text: "25분 운동 스피드 런"),
    RunningGuide(image: "runningGuide_02", title: "러닝 가이드 체험하기", subtitle: "Next Run", text: "24분 운동 회복 러닝"),
    RunningGuide(image: "runningGuide_03", title: "러닝 가이드 체험하기", subtitle: "First Run", text: "23분 운동 회복 러닝"),
    RunningGuide(image: "runningGuide_04", title: "러닝 가이드 체험하기", subtitle: "First Long Run", text: "35분 운동 장거리 러닝"),
    RunningGuide(image: "runningGuide_05", title: "러닝 가이드 체험하기", subtitle: "First Treadmill Run", text: "24분 운동 Treadmill Run"),
    RunningGuide(image: "runningGuide_06", title: "", subtitle: "NRC 크루들과 함께하는 러닝 가이드 더 보기", text: "")
]
