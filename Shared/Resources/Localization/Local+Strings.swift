//
//  Local+Strings.swift
//  Subs (iOS)
//
//  Created by Ahmed Magdi on 24/05/2021.
//

import Foundation


extension AppLocal {

    func localize(key: String) -> String {
        if let enumKey = Strings(rawValue: key) {
            return self[enumKey]
        }
        return "§\(key)§"
    }

    subscript(key: Strings) -> String {
        return NSLocalizedString(GeneratedStrings.shared.getLocal(key), bundle: Bundle.main, comment: "")
    }

    public class GeneratedStrings {
        static var shared = GeneratedStrings()
        var localValues: [Strings: String] = [:]

        func getLocal(_ key:Strings) -> String {
            return localValues[key] ?? "§\(key.rawValue)§"
        }

        init() {
            localValues[Strings.title_newSubscription] = "New Subscription"
            localValues[Strings.title_subscription] = "Subscriptions"
            
            localValues[Strings.button_add] = "Add"
            localValues[Strings.button_cancel] = "Cancel"
            
            localValues[Strings.label_itemName] = "Name"
            localValues[Strings.label_itemDescription] = "Description"
            localValues[Strings.label_itemCategory] = "Category"
            localValues[Strings.label_itemColor] = "Color"
            localValues[Strings.label_itemFirstBill] = "First Bill"
            localValues[Strings.label_itemCycle] = "Cycle"
            localValues[Strings.label_itemDuration] = "Duration"
            localValues[Strings.label_itemRemindMe] = "Remind Me"
            localValues[Strings.label_itemCurrency] = "Currency"
            
            localValues[Strings.label_itemPlaceholderName] = "Name"
            localValues[Strings.label_itemPlaceholderDescription] = "Description"
            localValues[Strings.label_itemPlaceholderCategory] = "Category"
            localValues[Strings.label_itemPlaceholderColor] = "Color"
            localValues[Strings.label_itemPlaceholderFirstBill] = "First Bill"
            localValues[Strings.label_itemPlaceholderCycle] = "Cycle"
            localValues[Strings.label_itemPlaceholderDuration] = "Duration"
            localValues[Strings.label_itemPlaceholderRemindMe] = "Remind Me"
            localValues[Strings.label_itemPlaceholderCurrency] = "Currency"
            
        }
    }

    public enum Strings: String, CaseIterable {

        public var localized: String {
            return AppLocal.default[self]
        }

        case title_newSubscription
        case title_subscription
        case button_add
        case button_cancel
        
        case label_itemName
        case label_itemDescription
        case label_itemCategory
        case label_itemColor
        case label_itemFirstBill
        case label_itemCycle
        case label_itemDuration
        case label_itemRemindMe
        case label_itemCurrency
        
        case label_itemPlaceholderName
        case label_itemPlaceholderDescription
        case label_itemPlaceholderCategory
        case label_itemPlaceholderColor
        case label_itemPlaceholderFirstBill
        case label_itemPlaceholderCycle
        case label_itemPlaceholderDuration
        case label_itemPlaceholderRemindMe
        case label_itemPlaceholderCurrency
    }
}

