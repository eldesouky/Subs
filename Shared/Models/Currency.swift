//
//  Currency.swift
//  Subs
//
//  Created by Mahmoud Eldesouky on 24.05.21.
//

import Foundation

final class Currency {
    var locale: Locale = Locale.current
    
    internal init() {}
    
    static func `default`() -> Currency {
        return Currency()
    }
    
    init(identifier: String) {
        locale = Locale(identifier: identifier)
    }
    
    var symbol: String {
        return locale.currencySymbol ?? ""
    }
}

// If you want to get the currency symbols
struct CurrencySymbols {
    static var all: [CurrencySymbols] {
        Locale.availableIdentifiers.map{CurrencySymbols(id: $0)}
    }
    
    let locale: Locale
    
    init(id: String) {
        locale = Locale(identifier: id)
    }
    
    var symbol: String {
        return locale.currencySymbol ?? ""
    }
}
