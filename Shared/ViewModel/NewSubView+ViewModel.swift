//
//  NewSubView+ViewModel.swift
//  Subs (iOS)
//
//  Created by Ahmed Magdi on 24/05/2021.
//

import SwiftUI
import Combine

extension NewSubView {
    class ViewModel : BaseViewModel {
        
        @Published var name: String
        @Published var detail: String
        @Published var color: Color
        @Published var firstBill: Date
        @Published var cycle: Cycle
        @Published var duration: Duration
        @Published var reminder: RemindMe
        @Published var currency: Currency
        @Published var amount: Double
        @Published var imageName: String
        
        @Published var remindMeString: String = ""
        @Published var image: Image = Image("netflix_logo")
        
        @Published var cycleCountSelection: Int
        @Published var cycleTypeSelection: Int
        @Published var durationCountSelection: Int
        @Published var durationTypeSelection: Int
        
        @Published var isDataValid: Bool = true
        
        private var cancellable = Set<AnyCancellable>()
        
        init(model: SubscriptionModel? = nil) {
            let model = model ?? SubscriptionModel()
            
            name = model.name
            detail = model.detail
            color = model.color
            firstBill = model.firstBill
            cycle = model.cycle
            duration = model.duration
            reminder = model.reminder
            currency = model.currency
            amount = model.amount
            imageName = model.icon
            
            cycleCountSelection = model.cycle.count.value
            cycleTypeSelection = model.cycle.type.rawValue
            durationCountSelection = model.duration.count.value
            durationTypeSelection = model.duration.type.rawValue
            super.init()
        }
        
        override func configureLinks() {
            super.configureLinks()
            
            Publishers.CombineLatest($cycleCountSelection, $cycleTypeSelection)
                .sink(receiveValue: { (p1, p2) in
                    self.cycle.update(numberIndex: p1, periodIndex: p2)
                }).store(in: &cancellable)
            
            Publishers.CombineLatest($durationCountSelection, $durationTypeSelection)
                .sink(receiveValue: { (p1, p2) in
                    self.duration.update(numberIndex: p1, periodIndex: p2)
                }).store(in: &cancellable)
            
            $durationCountSelection
                .filter{$0 == 0}
                .assign(to: &$durationTypeSelection)
           
            //            Publishers.CombineLatest(model.name, model.amount)
            //                .eraseToAnyPublisher()
            //                .map { StyleSheet.validate(input: $0) && StyleSheet.validate(input: "\($1)")}
            //                .assign(to: &$isDataValid)
            
            $imageName
                .filter {!$0.isEmpty}
                .map { name in
                    return Image("netflix_logo")
                }
                .assign(to: &$image)
        }
        
        func storeItem() -> Bool {
            let model = Subscription(context: self.context)
            model.name = name
            model.color = color.hexStringFromColor()
            model.cyclePeriodType = cycle.type.toInt16
            model.cyclePeriodCount = cycle.count.toInt16
            model.durationPeriodType = duration.type.toInt16
            model.durationPeriodCount = duration.count.toInt16
            
            model.detail = detail
            model.firstBill = firstBill
            model.reminder = reminder.rawValue
            model.currency = currency.locale.identifier
            model.amount = amount
            model.icon = imageName
            do {
                try saveContext()
            } catch {
                fatalError("error saving context while creating an object")
            }
            return true
        }
    }
}

