//
//  Styleheet.swift
//  Subs (iOS)
//
//  Created by Ahmed Magdi on 24/05/2021.
//

import SwiftUI

final class StyleSheet {
    
    struct Colors {
        static let lightGray = Color(#colorLiteral(red: 0.8745098039, green: 0.8784313725, blue: 0.8862745098, alpha: 1))
        static let mainBackgroundColor = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }
    
    static var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "MM/DD/YY"
        df.dateStyle = .long
        df.timeStyle = .none
        df.locale = .current
        return df
    }
    
    // This will get us the currency label as well
    static var currencyFormatter : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.maximumFractionDigits = 2;
        return formatter
    }
    
    static func currencyList() -> [String] {
        return [Locale.current.currencySymbol ?? "", Locale.current.currencySymbol ?? "", Locale.current.currencySymbol ?? ""]
    }
    
    static func currencyFormat(amount: Double, local: Locale = Locale(identifier: "de_DE")) -> String {
        let formatter = currencyFormatter
        formatter.locale = local
        
        guard let emptyValue = formatter.string(from: .init(value: 0)) else {
            return ""
        }
        return formatter.string(from: .init(value: amount)) ?? emptyValue
    }
    
    static func validate(input: String, regex: ValidationRegex = .nonEmpty) -> Bool {
        let test = NSPredicate(format: "SELF MATCH %@", regex.rawValue)
        return test.evaluate(with: input)
    }
}
