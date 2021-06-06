//
//  RemindMe.swift
//  Subs
//
//  Created by Ahmed Magdi on 06/06/2021.
//

import Foundation

enum RemindMe: Int16 {
    case none
    case min5
    case min10
    case min15
    case min30
    case hour1
    case hour2
    case day1
    case day2
    case week1
    
    var stringValue: String {
        switch self {
        case .none:
            return AppLocal.default[.label_reminderNone]
        case .min5:
            return AppLocal.default[.label_reminderMinutes5]
        case .min10:
            return AppLocal.default[.label_reminderMinutes10]
        case .min15:
            return AppLocal.default[.label_reminderMinutes15]
        case .min30:
            return AppLocal.default[.label_reminderMinutes30]
        case .hour1:
            return AppLocal.default[.label_reminderMinutes30]
        case .hour2:
            return AppLocal.default[.label_reminderHours2]
        case .day1:
            return AppLocal.default[.label_reminderDay1]
        case .day2:
            return AppLocal.default[.label_reminderDays2]
        case .week1:
            return AppLocal.default[.label_reminderWeek1]
        }
    }
}
