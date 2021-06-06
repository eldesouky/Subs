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
            return "None"
        case .min5:
            return "5 minutes before"
        case .min10:
            return "10 minutes before"
        case .min15:
            return "15 minutes before"
        case .min30:
            return "30 minutes before"
        case .hour1:
            return "1 hour before"
        case .hour2:
            return "2 hours before"
        case .day1:
            return "1 day before"
        case .day2:
            return "2 days before"
        case .week1:
            return "1 week before"
        }
    }
}
