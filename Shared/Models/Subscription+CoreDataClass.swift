//
//  Subscription+CoreDataClass.swift
//  Subs
//
//  Created by Mahmoud Eldesouky on 23.05.21.
//
//

import SwiftUI
import CoreData

@objc(Subscription)
public class Subscription: NSManagedObject {
    
}

extension Subscription {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subscription> {
        return NSFetchRequest<Subscription>(entityName: "Subscription")
    }
    
    @NSManaged public var type: Int16
    @NSManaged public var detail: String?
    @NSManaged public var color: String?
    @NSManaged public var firstBill: Date
    @NSManaged public var durationPeriodCount: Int16
    @NSManaged public var durationPeriodType: Int16
    @NSManaged public var cyclePeriodCount: Int16
    @NSManaged public var cyclePeriodType: Int16
    @NSManaged public var reminder: Int16
    @NSManaged public var currency: String
    @NSManaged public var name: String
    @NSManaged public var icon: String?
    @NSManaged public var amount: Double
    
    @discardableResult
    static func createDummy(context: NSManagedObjectContext) -> Subscription{
        let newSub = Subscription(context: context)
        let subType = SubscriptionType.allCases[Int.random(in: 0 ... SubscriptionType.allCases.count - 1)]
        newSub.amount = Double.random(in: 1.99 ... 29.99).rounded(toPlaces: 2)
        newSub.currency = Currency.default().symbol
        newSub.cyclePeriodType = 0
        newSub.cyclePeriodCount = 30
        newSub.detail = Int.random(in: 0 ... 1) == 0 ? nil : "main"
        newSub.durationPeriodType = 2
        newSub.durationPeriodCount = 2
        newSub.firstBill = Date()
        newSub.type = subType.rawValue
        newSub.name = subType.getName()
        newSub.icon = subType.getIcon()
        newSub.color = subType.getColor()
        return newSub
    }
}

extension Subscription : Identifiable {
    
    func model() -> SubscriptionModel {
        return .init(dbModel: self)
    }
    
    func update(model: SubscriptionModel) {
        let subType = SubscriptionType.allCases[Int.random(in: 0 ... SubscriptionType.allCases.count - 1)]
        self.amount = model.amount
        self.currency = model.currency.locale.identifier
        self.cyclePeriodType = model.cycle.type.toInt16
        self.cyclePeriodCount = model.cycle.count.toInt16
        self.detail = model.detail.isEmpty ? nil : model.detail
        self.durationPeriodType = model.duration.type.toInt16
        self.durationPeriodCount = model.duration.count.toInt16
        self.firstBill = model.firstBill
        self.type = subType.rawValue
        self.name = model.name
        self.icon = model.icon
        self.color = model.color.hexStringFromColor()
    }
}
