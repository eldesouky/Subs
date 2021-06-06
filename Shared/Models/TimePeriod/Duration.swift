//
//  Duration.swift
//  Subs
//
//  Created by Ahmed Magdi on 27/05/2021.
//

import SwiftUI

class Duration: PeriodTimeObject {
    static fileprivate let pickerTypeColumnList = PeriodType.allCases
    static fileprivate var list: [String] = Array(1...30).map{"\($0)"}
    
    override var stringValue: String {
        return "\(count.stringValue) \(type.presentationValue)"
    }
    
    override func update(numberIndex: Int, periodIndex: Int) {
        self.type = Duration.pickerTypeColumnList[periodIndex]
        if let value = Int(pickerCountColumn()[numberIndex]) {
            count = PeriodCount(value: value)
        }
    }
    
    override func pickerCountColumn() -> [String] {
        var tmpList = ["Forever"]
        tmpList.append(contentsOf: Duration.list)
        return tmpList
    }
    
    override func pickerTypeColumn() -> [String] {
        return PeriodType.allCases.map({$0.presentationValue})
    }
}
