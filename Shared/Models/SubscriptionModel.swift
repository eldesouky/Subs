//
//  SubscriptionModel.swift
//  Subs
//
//  Created by Ahmed Magdi on 26/05/2021.
//

import SwiftUI

enum TimePeriodCategory: Int16, CaseIterable {
    case forever = 0
    case day = 1
    case month = 2
    case year = 3
    
    var value: String {
        switch self {
        case .forever:
            return "Forever"
        case .day:
            return "Day(s)"
        case .month:
            return "Month(s)"
        case .year:
            return "Year(s)"
        }
    }
}

// xx-y    -> xx is number of occurances, y is < day, month, year >
struct Cycle {
    var period: TimePeriodCategory = .month
    // from 0 -> 30
    var number: Int16 = 1
    
    init(value: String) {
        let cycleInfo: [String] = value.components(separatedBy: "-")
        if let stringValue = cycleInfo.first,
           let periodValue = Int16(stringValue),
           let period: TimePeriodCategory = TimePeriodCategory(rawValue: periodValue) {
            self.period = period
        }
        
        if let stringValue = cycleInfo.last,
           let numberValue = Int16(stringValue) {
            self.number = numberValue
        }
    }
    
    init(number: Int16, period: TimePeriodCategory) {
        self.period = period
        self.number = number
    }
    
    internal init() {}
    
    static func `default`() -> Cycle {
        return Cycle()
    }
}

struct Duration {
    var period: TimePeriodCategory = .month
    // from 0 -> 30
    var number: Int16 = 1
    
    init(value: String) {
        let cycleInfo: [String] = value.components(separatedBy: "-")
        if let stringValue = cycleInfo.first,
           let periodValue = Int16(stringValue),
           let period: TimePeriodCategory = TimePeriodCategory(rawValue: periodValue) {
            self.period = period
        }
        
        if let stringValue = cycleInfo.last,
           let numberValue = Int16(stringValue) {
            self.number = numberValue
        }
    }
    
    internal init() {}
    init(number: Int16, period: TimePeriodCategory) {
        self.period = period
        self.number = number
    }
    
    static func `default`() -> Duration {
        return Duration()
    }
}

struct Currency_ {
    var locale: Locale = Locale.current
    
    var symbol: String {
        return locale.currencySymbol ?? ""
    }
}

struct SubscriptionIcon {
    let name: String
    
    var image: Image {
        return Image(name)
    }
    
    init(name: String) {
        self.name = name
    }
    
    static func `default`() -> SubscriptionIcon {
        return SubscriptionIcon(name: "netflix_2")
    }
}


final class SubscriptionModel: Identifiable {
    let id = UUID()
    
    var name: String = ""
    var type: SubscriptionType = .appleArcade
    var detail: String?
    var color: Color = .white
    var firstBill: Date? = .init()
    var cycle: Cycle = .default()
    var duration: Duration = .init()
    var reminder: Int16?
    var currency: Currency_ = .init()
    var icon: SubscriptionIcon = .default()
    var amount: Double = 0.0
    
    init() {}
    
    init(type: SubscriptionType, detail: String? = nil, color: Color, firstBill: Date? = nil, cycle: (number: Int16, period: TimePeriodCategory), duration: (number: Int16, period: TimePeriodCategory), name: String, icon: SubscriptionIcon = .default(), amount: Double) {
        self.type = type
        self.detail = detail
        self.color = color
        self.firstBill = firstBill
        self.cycle = Cycle(number: cycle.number, period: cycle.period)
        self.duration = Duration(number: duration.number, period: duration.period)
        self.name = name
        self.icon = icon
        self.amount = amount
    }
    
    //    init(subscription item: Subscription) {
    //        if let value = SubscriptionType(rawValue: item.type)  {
    //            self.type = value
    //        } else {
    //            self.type = .appleArcade
    //        }
    //
    //        if let colorName = item.color {
    //            self.color = Color(colorName)
    //        } else {
    //            self.color = Color.white
    //        }
    //        self.detail = item.detail
    //        self.firstBill = item.firstBill
    //        self.cycle = Cycle()
    //        self.duration = item.duration
    //        self.name = item.name
    //        self.icon = item.icon
    //        self.amount = item.amount
    //    }
}
