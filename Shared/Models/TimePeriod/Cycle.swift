//
//  Cycle.swift
//  Subs
//
//  Created by Ahmed Magdi on 27/05/2021.
//

import SwiftUI

class Cycle: PeriodTimeObject {
    static fileprivate var list: [String] = Array(1...30).map{"\($0)"}
    static fileprivate let pickerTypeColumnList = [PeriodType.day, PeriodType.month, PeriodType.year]
    
    
    override var stringValue: String {
        return "\(count == .forever ? "":"Every ")\(count.stringValue) \(type.presentationValue)"
    }
    
    override func update(numberIndex: Int, periodIndex: Int) {
        self.type = Cycle.pickerTypeColumnList[periodIndex]
        
        if let value = Int(pickerCountColumn()[numberIndex]) {
            count = PeriodCount.custom(value)
        }
    }
    
    override func pickerCountColumn() -> [String] {
        return Cycle.list
    }
    
    override func pickerTypeColumn() -> [String] {
        return Cycle.pickerTypeColumnList.map({$0.presentationValue})
    }
}
