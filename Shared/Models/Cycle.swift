//
//  Cycle.swift
//  Subs
//
//  Created by Ahmed Magdi on 27/05/2021.
//

import SwiftUI

enum PeriodCategry: Equatable {
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
    
    var intValue: Int {
        switch self {
        case .forever:
            return 0
        case let .custom(count):
            return count
        }
    }
    
}

internal class TimePeriodObject {
    var period: TimePeriod = .month
    var number: PeriodCategry = .forever
    
    var stringValue: String { "" }
    
    init(value: String) {
        let cycleInfo: [String] = value.components(separatedBy: "-")
        if let stringValue = cycleInfo.first,
           let periodValue = Int(stringValue),
           let period: TimePeriod = TimePeriod(rawValue: periodValue) {
            self.period = period
        }
        
        if let stringValue = cycleInfo.last,
           let numberValue = Int(stringValue) {
            self.number = .custom(numberValue)
        }
    }
    
    init(number: Int, period: TimePeriod) {
        self.period = period
        self.number = .custom(number)
    }
    
    func update(numberIndex: Int, periodIndex: Int) {}
    
    init() {}
    
    func calculate(since oldDate: Date) -> Date? {
        var dateComponent = DateComponents()
        var component: Calendar.Component = .month
        switch period {
        case .none:
            return nil
        case .day :
            component = .day
        case .month :
            component = .month
        case .year :
            component = .year
        }
        dateComponent.setValue(number.intValue, for: component)
        let newDate = Calendar.current.date(byAdding: dateComponent, to: oldDate)
        return newDate
    }
    
    static fileprivate var list: [String] = Array(1...30).map{"\($0)"}
}



class Cycle: TimePeriodObject {
    override var stringValue: String {
        return "\(number == .forever ? "":"Every ")\(number.stringValue) \(period.presentationValue)"
    }
    
    override func update(numberIndex: Int, periodIndex: Int) {
        self.period = Cycle.periodOptionsList[periodIndex]

        if let value = Int(Cycle.pickerColoumOne()[numberIndex]) {
            number = PeriodCategry.custom(value)
        }
    }
    
    static func pickerColoumOne() -> [String] {
        return list
    }
    
    static fileprivate let periodOptionsList = [TimePeriod.day, TimePeriod.month, TimePeriod.year]
    static func periodOptions() -> [String] {
        return periodOptionsList.map({$0.presentationValue})
    }
}

class Duration: TimePeriodObject {
    override var stringValue: String {
        return "\(number.stringValue) \(period.presentationValue)"
    }
    
    override func update(numberIndex: Int, periodIndex: Int) {
        self.period = Cycle.periodOptionsList[periodIndex]
        if let value = Int(Duration.pickerColoumOne()[numberIndex]) {
            number = PeriodCategry(value: value)
        }
    }
    
    static func pickerColoumOne() -> [String] {
        var tmpList = ["Forever"]
        tmpList.append(contentsOf: list)
        return tmpList
    }
    
    static fileprivate let periodOptionsList = TimePeriod.allCases
    static func periodOptions() -> [String] {
        return TimePeriod.allCases.map({$0.presentationValue})
    }
}
