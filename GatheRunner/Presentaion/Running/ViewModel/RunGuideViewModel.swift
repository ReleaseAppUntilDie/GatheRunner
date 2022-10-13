//
//  RunGuideExperienceVM.swift
//  GatheRunner
//
//  Created by cho on 2022/07/16.
//

import SwiftUI

class RunGuideViewModel: ObservableObject {

    // MARK: Internal

    var getArrsRunGuideExperienceItem: [RunGuideItem] {
        runGuideExperienceItem
    }

    // MARK: Private

    // MARK: 서버 API 미구현 상태 -> 임시로 선언한 더미 데이터 -> API 구현 후 해당 코드 변경 예정
    private var runGuideExperienceItem = [
        RunGuideItem(
            image: "RunGuideImage_1",
            title: "이렇게 쉽고 재미있을 순 없을걸",
            subtitle: "초급자",
            contents: "10분 가볍게 러닝",
            workoutGoal: "초급자도 쉽게 즐길수 있는 운동입니다. 부담없이 러닝 고고싱!",
            workoutComposition: "10분의 편안한 러닝"),
        RunGuideItem(
            image: "RunGuideImage_2",
            title: "중급중급중급중급",
            subtitle: "중급자",
            contents: "20분 적당한 속도로 러닝",
            workoutGoal: "이제 갓 초급 딱지를 뗀 당신에게 추천하는 운동입니다",
            workoutComposition: "20분의 과호흡 러닝"),
        RunGuideItem(
            image: "RunGuideImage_3",
            title: "좀 빡세요",
            subtitle: "상급자",
            contents: "40분 인터벌 러닝",
            workoutGoal: "러닝 크루의 리더인 당신에게 추천하는 운동입니다",
            workoutComposition: "40분의 심장 과부하 러닝"),
        RunGuideItem(
            image: "RunGuideImage_4",
            title: "프로 선수를 위한 워크아웃",
            subtitle: "Pro",
            contents: "60분 중거리 러닝",
            workoutGoal: "국내 대회 입상을 위한 체계적이고 과학적인 워크아웃",
            workoutComposition: "60분의 이승 탈출 워크아웃"),
        RunGuideItem(
            image: "RunGuideImage_5",
            title: "For Olympia",
            subtitle: "Ultra",
            contents: "120분 장거리 러닝",
            workoutGoal: "올림픽 메달리스트가 되기 위한 태릉식 워크아웃",
            workoutComposition: "120일 처럼 느껴지는 120분"),
    ]
}
