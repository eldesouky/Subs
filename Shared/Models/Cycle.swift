//
//  Cycle.swift
//  Subs
//
//  Created by Ahmed Magdi on 27/05/2021.
//

import SwiftUI

class Cycle {
    struct DaysCount {
        enum SelectionType {
            case forever
            case custom(Int16)
            
            var rawValue: Int16 {
                switch self {
                case .forever: return 0
                case let .custom(value): return value
                }
            }
        }
        
        static private var list: [String] = Array(1...30).map{"\($0)"}
        
        var value: SelectionType
    }
    
    var period: TimePeriod = .month
    // from 1 -> 30
    var number: Int16 = 1
    
    init(value: String) {
        let cycleInfo: [String] = value.components(separatedBy: "-")
        if let stringValue = cycleInfo.first,
           let periodValue = Int16(stringValue),
           let period: TimePeriod = TimePeriod(rawValue: periodValue) {
            self.period = period
        }
        
        if let stringValue = cycleInfo.last,
           let numberValue = Int16(stringValue) {
            self.number = numberValue
        }
    }
    
    init(number: Int16, period: TimePeriod) {
        self.period = period
        self.number = number
    }
    
    init(numberIndex: Int, periodIndex: Int) {
        if let period = TimePeriod(rawValue: Int16(periodIndex)) {
            self.period = period
        }
    }
    
    init() {}
    
    func calculate(since oldDate: Date) -> Date? {
        var dateComponent = DateComponents()
        var component: Calendar.Component = .month
        switch period {
        case .day :
            component = .day
        case .month :
            component = .month
        case .year :
            component = .year
        }
        dateComponent.setValue(Int(number), for: component)
        let newDate = Calendar.current.date(byAdding: dateComponent, to: oldDate)
        return newDate
    }
    
    static func periodOptions() -> [String] {
        return TimePeriod.allCases.map({$0.presentationValue})
    }
}
