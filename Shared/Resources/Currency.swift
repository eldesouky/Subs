//
//  Currency.swift
//  Subs
//
//  Created by Mahmoud Eldesouky on 24.05.21.
//

import Foundation
enum Currency: Int16, CaseIterable {
    case €, `$`
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
