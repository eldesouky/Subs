//
//  SubscriptionModel.swift
//  Subs
//
//  Created by Ahmed Magdi on 26/05/2021.
//

import SwiftUI

final class SubscriptionModel: Identifiable {
    let id = UUID()
    
    var name: String = ""
    var type: SubscriptionType = .appleArcade
    var detail: String = ""
    var color: Color = .white
    var firstBill: Date = .init()
    var cycle: Cycle = Cycle()
    var duration: Duration = .init()
    var reminder: RemindMe = .none
    var currency: Currency = .default()
    var icon: String = "netflix_logo"
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
        self.detail = item.detail ?? ""
        self.firstBill = item.firstBill
        self.cycle = Cycle(periodCount: item.cyclePeriodCount, periodType: item.cyclePeriodType)
        self.duration = Duration(periodCount: item.durationPeriodCount, periodType: item.durationPeriodType)
        self.name = item.name
        if let selectedIcon = item.icon {
            self.icon = selectedIcon
        }
        self.amount = item.amount
        
        self.reminder = RemindMe(rawValue: item.reminder) ?? .none
    }
}
