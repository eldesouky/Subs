////
////  Duration.swift
////  Subs
////
////  Created by Ahmed Magdi on 27/05/2021.
////
//
//import SwiftUI
//
//class Duration {
//    var period: TimePeriod = .month
//    var number: PeriodCategry = .forever
//    
//    init(value: String) {
//        let cycleInfo: [String] = value.components(separatedBy: "-")
//        if let stringValue = cycleInfo.first,
//           let periodValue = Int(stringValue),
//           let period: TimePeriod = TimePeriod(rawValue: periodValue) {
//            self.period = period
//        }
//        
//        if let stringValue = cycleInfo.last,
//           let numberValue = Int(stringValue) {
//            self.number = PeriodCategry(value: numberValue)
//        }
//    }
//    
//    init(number: Int, period: TimePeriod) {
//        self.period = period
//        self.number = PeriodCategry(value: number)
//    }
//    
//    init() {}
//    
//    var stringValue: String {
//        return "\(number.stringValue) \(period.presentationValue)"
//    }
//    
//    func update(numberIndex: Int, periodIndex: Int) {
//        if let period = TimePeriod(rawValue: Int(periodIndex)) {
//            self.period = period
//        }
//        
//        number = PeriodCategry(value: numberIndex)
//    }
//    
//}
