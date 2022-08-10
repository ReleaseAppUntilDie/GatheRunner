//
//  GraphView.swift
//  GatheRunner
//
//  Created by jaeseung han on 2022/07/29.
//

import SwiftUI

fileprivate enum TimeUnit {
    case week,month,year,whole
}

struct GraphView: View {
    
    @State private var selectedTimeUnit : TimeUnit = .week
    var unitIndex : Double {
        switch selectedTimeUnit {
        case .week: return 0
        case .month: return 1
        case .year: return 2
        case .whole: return 3
        }
    }
    
    
    var body: some View {
        VStack {
            TimeUnitsTable(curTimeUnit: $selectedTimeUnit,unitIndex: unitIndex)
                .onTouch(type: .started) { point in
                    withAnimation {
                        if point.x < UIScreen.getWidthby(ratio: 0.2) {
                            selectedTimeUnit = .week
                        } else if point.x >= UIScreen.getWidthby(ratio: 0.2)&&point.x<UIScreen.getWidthby(ratio: 0.4){
                            selectedTimeUnit = .month
                        } else if point.x >= UIScreen.getWidthby(ratio: 0.4)&&point.x<UIScreen.getWidthby(ratio: 0.6) {
                            selectedTimeUnit = .year
                        } else {
                            selectedTimeUnit = .whole
                        }
                    }
                }
            
            SimplifiedStatistics(selectedTimeUnit: .week)
        }
    }
}

struct TimeUnitsTable : View{
    
    @Binding fileprivate var curTimeUnit : TimeUnit
    let unitIndex : Double
    
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: UIScreen.getHeightby(ratio: 0.02))
                .strokeBorder(Color(uiColor: .systemGray4),lineWidth: 2)
                .frame(width: UIScreen.getWidthby(ratio: 0.8), height: UIScreen.getHeightby(ratio: 0.04))
            
            ZStack {
                RoundedRectangle(cornerRadius: UIScreen.getHeightby(ratio: 0.02))
                    .fill(Color.green)
                    .frame(width: UIScreen.getWidthby(ratio: 0.2), height: UIScreen.getHeightby(ratio: 0.04))
                    .offset(x: -UIScreen.getWidthby(ratio: 0.3) + UIScreen.getWidthby(ratio: 0.2 * unitIndex))
                HStack(spacing:0){
                    TimeUnitComponent(selectedTimeUnit: $curTimeUnit, timeUnit: .week, title: "주")
                        .frame(width: UIScreen.getWidthby(ratio: 0.2))
                    TimeUnitComponent(selectedTimeUnit: $curTimeUnit, timeUnit: .month, title: "월")
                        .frame(width: UIScreen.getWidthby(ratio: 0.2))
                    TimeUnitComponent(selectedTimeUnit: $curTimeUnit, timeUnit: .year, title: "년")
                        .frame(width: UIScreen.getWidthby(ratio: 0.2))
                    TimeUnitComponent(selectedTimeUnit: $curTimeUnit, timeUnit: .whole, title: "전체")
                        .frame(width: UIScreen.getWidthby(ratio: 0.2))
                }
            }
            
        }
    }
    struct TimeUnitComponent : View {
        @Binding fileprivate var selectedTimeUnit : TimeUnit
        fileprivate let timeUnit : TimeUnit
        let title : String
        var body : some View {
            Text(title)
                .foregroundColor(selectedTimeUnit == timeUnit ? .black : .init(uiColor: .systemGray2))
        }
    }
}

struct SimplifiedStatistics: View{
    
    fileprivate let selectedTimeUnit : TimeUnit
    
    var body: some View{
        VStack(alignment: .leading,spacing: UIScreen.getHeightby(ratio: 0.1)) {
            
        }
        .onAppear {
            print(beforeTwoWeeks())
            print(beforeThreeWeeks())
        }
    }
    
    func beforeTwoWeeks() -> (firstDay:Int?,firstMonth:Int?,lastDay:Int?,lastMonth:Int?){
        let date = Date()
        guard let weekDay = Calendar.current.dateComponents([.weekday], from: date).weekday else {
            return (nil,nil,nil,nil)
        }
        
        guard let beforeTwoWeeks = Calendar.current.date(byAdding: .day, value: -(14+(weekDay-2)), to: date) else {
            return (nil,nil,nil,nil)
        }
        guard let beforeOneWeek = Calendar.current.date(byAdding: .day, value: -(7+(weekDay-1)), to: date) else {
            return (nil,nil,nil,nil)
        }
        
        let firstDateAndMonth = Calendar.current.dateComponents([.month,.day], from: beforeTwoWeeks)
        let lastDateAndMonth = Calendar.current.dateComponents([.month,.day], from: beforeOneWeek)
        return (firstDateAndMonth.day,firstDateAndMonth.month,lastDateAndMonth.day,lastDateAndMonth.month)
    }
    
    func beforeThreeWeeks() -> (firstDay:Int?,firstMonth:Int?,lastDay:Int?,lastMonth:Int?){
        let date = Date()
        guard let weekDay = Calendar.current.dateComponents([.weekday], from: date).weekday else {
            return (nil,nil,nil,nil)
        }
        
        guard let beforeTwoWeeks = Calendar.current.date(byAdding: .day, value: -(21+(weekDay-2)), to: date) else {
            return (nil,nil,nil,nil)
        }
        guard let beforeOneWeek = Calendar.current.date(byAdding: .day, value: -(14+(weekDay-1)), to: date) else {
            return (nil,nil,nil,nil)
        }
        
        let firstDateAndMonth = Calendar.current.dateComponents([.month,.day], from: beforeTwoWeeks)
        let lastDateAndMonth = Calendar.current.dateComponents([.month,.day], from: beforeOneWeek)
        return (firstDateAndMonth.day,firstDateAndMonth.month,lastDateAndMonth.day,lastDateAndMonth.month)
    }
}


struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}



