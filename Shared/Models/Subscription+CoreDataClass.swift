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
    @NSManaged public var firstBill: Date?
    @NSManaged public var cycle: Int16
    @NSManaged public var duration: Int16
    @NSManaged public var reminder: Int16
    @NSManaged public var currency: Int16
    @NSManaged public var name: String
    @NSManaged public var icon: String?
    @NSManaged public var amount: Double
    
    @discardableResult
    static func createDummy(context: NSManagedObjectContext) -> Subscription {
        let newSub = Subscription()
        let subType = SubscriptionType.allCases[Int.random(in: 0 ... SubscriptionType.allCases.count - 1)]
        newSub.amount = Double.random(in: 1.99 ... 29.99).rounded(toPlaces: 2)
        newSub.currency = Currency.€.rawValue
        newSub.cycle = 30
        newSub.detail = Int.random(in: 0 ... 1) == 0 ? nil : "main"
        newSub.duration =  3000
        newSub.firstBill = Date()
        newSub.type = subType.rawValue
        newSub.name = subType.getName()
        newSub.icon = subType.getIcon()
        newSub.color = subType.getColor()
        return newSub
    }
    
    static func create() -> Subscription {
        let newSub = Subscription()
        let subType = SubscriptionType.allCases[Int.random(in: 0 ... SubscriptionType.allCases.count - 1)]
        newSub.amount = Double.random(in: 1.99 ... 29.99).rounded(toPlaces: 2)
        newSub.currency = Currency.€.rawValue
        newSub.cycle = 30
        newSub.detail = Int.random(in: 0 ... 1) == 0 ? nil : "main"
        newSub.duration =  3000
        newSub.firstBill = Date()
        newSub.type = subType.rawValue
        newSub.name = subType.getName()
        newSub.icon = subType.getIcon()
        newSub.color = subType.getColor()

        return newSub
    }

}

extension Subscription : Identifiable {

}
