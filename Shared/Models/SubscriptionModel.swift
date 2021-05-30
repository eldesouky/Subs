//
//  SubscriptionModel.swift
//  Subs
//
//  Created by Ahmed Magdi on 26/05/2021.
//

import SwiftUI

enum TimePeriod: Int16, CaseIterable {
    case day = 0
    case month = 1
    case year = 2
    
    var presentationValue: String {
        switch self {
        case .day:
            return "Day(s)"
        case .month:
            return "Month(s)"
        case .year:
            return "Year(s)"
        }
    }
}

final class SubscriptionModel: Identifiable {
    let id = UUID()
    
    var name: String = ""
    var type: SubscriptionType = .appleArcade
    var detail: String?
    var color: Color = .white
    var firstBill: Date = .init()
    var cycle: Cycle = Cycle()
    var duration: Duration = .init()
    var reminder: Int16?
    var currency: Currency = .default()
    var icon: String = "netflix_2"
    var amount: Double = 0.0
    
    init() {}
     
    init(dbModel item: Subscription) {
        if let value = SubscriptionType(rawValue: item.type)  {
            self.type = value
        } else {
            self.type = .appleArcade
        }
        
        if let colorName = item.color {
            self.color = Color(hex: colorName)
        } else {
            self.color = Color.white
        }
        self.detail = item.detail
        self.firstBill = item.firstBill
        self.cycle = Cycle(value: item.cycle)
        self.duration = Duration(value: item.duration)
        self.name = item.name
        if let selectedIcon = item.icon {
            self.icon = selectedIcon
        }
        self.amount = item.amount
    }
        
}
