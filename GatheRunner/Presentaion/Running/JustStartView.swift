//
//  JustStartView.swift
//  GatheRunner
//
//  Created by cho on 2022/07/09.
//

import SwiftUI
import MapKit

struct JustStartView: View {
    @StateObject private var manager = LocationManager()
    @Binding var selected: Int
    let timer = Timer.publish(every: 5.5, on: .main, in: .default).autoconnect()
    var runningGuideArrs = RunningGuideViewModel().getRunningGuideArrs
    let forMapRadialGradient: Gradient = Gradient(colors: [Color.white.opacity(0), Color.white, Color.white, Color.white, Color.white, Color.white.opacity(1)])
    
    var body: some View {
        ZStack {
            mapView
            VStack {
                featuredTabView
                Spacer()
                FloatingView()
            }
        }
    }
    
    var mapView: some View {
        Map(coordinateRegion: $manager.region, showsUserLocation: true).disabled(true)
    }
    
    var featuredTabView: some View {
        VStack {
            TabView(selection: $selected) {
                RunningGuideTabItem()
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.2)
            .shadow(radius: 2)
            .padding(-15)
            // 러닝가이드 탭뷰를 탭했을때 실행될 이벤트
            // timer가 멈추도록 해서 일정 시간 이후 해당 탭뷰가 자동으로 전환되지 않도록 한다.
            .onTapGesture {
                // timer의 connect 인스턴스 메서드는 upstream 내부에 정의되어 있으므로 upstream에 접근한다.
                timer.upstream.connect().cancel()
            }
            // 여러 제스처를 동시에 사용하고 싶을때에는 simultaneously()를 사용하지만 편의상 highPriorityGesture를 사용해 우선순위를 두고 이와 같이 사용해도 된다.
            // highPriorityGesture를 사용하지 않고 두개의 제스처를 simultaneously() 없이 사용한다면 코드 아래에 있는 제스처는 정상적으로 작동하지 않는다.
            .highPriorityGesture (
                DragGesture()
                    .onChanged { _ in
                        // onChanged는 실제로 드래그 하는 동안 좌표값을 실시간으로 리턴하지만 그렇다고 해서 코드 내부에 있는 메서드의 실행이나 변수의 값변경을 연속적으로 처리하는 것은 아니다.
                        // 드래그할때 딱 한번만 메서드가 실행된다. 따라서 아래 메서드는 드래그 하는 동안 한번만 호출된다.
                        timer.upstream.connect().cancel()
                    }
            )
            .onReceive(timer) { time in
                if runningGuideArrs.count - 1 >= selected + 1 {
                    selected += 1
                } else {
                    timer.upstream.connect().cancel()
                }
            }.animation(.default, value: selected)
            
            HStack(spacing: 5) {
                ForEach(runningGuideArrs.indices, id: \.self) { index in
                    Capsule()
                        .fill(Color.black.opacity(selected == index ? 1 : 0.55))
                        .frame(width: selected == index ? 18 : 6, height: 4)
                        .animation(.easeInOut, value: selected)
                }
            }
        }
    }
}

struct JustStartView_Previews: PreviewProvider {
    static var previews: some View {
        JustStartView(selected: .constant(0)).environmentObject(GoalSettingViewModel())
    }
}
