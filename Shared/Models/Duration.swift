//
//  Duration.swift
//  Subs
//
//  Created by Ahmed Magdi on 27/05/2021.
//

import SwiftUI

class Duration {
    var period: TimePeriod = .month
    
    // from 0 -> 30
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
}
