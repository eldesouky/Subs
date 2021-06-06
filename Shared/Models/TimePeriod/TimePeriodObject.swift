//
//  TimePer.swift
//  Subs
//
//  Created by Ahmed Magdi on 06/06/2021.
//

import SwiftUI

enum PeriodType: Int, CaseIterable {
    case none = 0
    case day = 1
    case month = 2
    case year = 3
    
    var presentationValue: String {
        switch self {
        case .none:
            return ""
        case .day:
            return "Day(s)"
        case .month:
            return "Month(s)"
        case .year:
            return "Year(s)"
        }
    }
    
    var toInt16: Int16 {
        return Int16(self.rawValue)
    }
}

enum PeriodCount: Equatable {
    typealias RawValue = Int
    
    case forever
    case custom(Int)
    
    init(value: Int) {
        if value == 0 {
            self = .forever
        } else {
            self = .custom(value)
        }
    }
    
    var stringValue: String {
        switch self {
        case .forever:
            return "Forever"
        case let .custom(count):
            return "\(count)"
        }
    }
    
    var value: Int {
        switch self {
        case .forever:
            return 0
        case let .custom(count):
            return count
        }
    }
    
    var toInt16: Int16 {
        return Int16(self.value)
    }
}

class PeriodTimeObject {
    var type: PeriodType = .month
    var count: PeriodCount = .forever
    
    var stringValue: String { "" }
    
    init(periodCount: Int16, periodType: Int16) {
        if let period: PeriodType = PeriodType(rawValue: Int(periodCount)) {
            self.type = period
        }
        self.count = .custom(Int(periodType))
    }
    
    init(number: Int, period: PeriodType) {
        self.type = period
        self.count = .custom(number)
    }
    
    func update(numberIndex: Int, periodIndex: Int) {}
    
    init() {}
    
    func calculate(since oldDate: Date) -> Date? {
        var dateComponent = DateComponents()
        var component: Calendar.Component = .month
        switch type {
        case .none:
            return nil
        case .day :
            component = .day
        case .month :
            component = .month
        case .year :
            component = .year
        }
        dateComponent.setValue(count.value, for: component)
        let newDate = Calendar.current.date(byAdding: dateComponent, to: oldDate)
        return newDate
    }
    
    func pickerCountColumn() -> [String] {
        return []
    }
    
    func pickerTypeColumn() -> [String] {
        return []
    }
}


