//
//  Reminder.swift
//  Subs
//
//  Created by Ahmed Magdi on 24/05/2021.
//

import Foundation



struct Reminder: Hashable {
    enum Period: String, CaseIterable {
        case forever = "Forever"
        case day = "Day(s)"
        case month = "Month(s)"
        case year = "Year(s)"
    }
    
    var amount: Int?
    var period: Reminder.Period
    
}
