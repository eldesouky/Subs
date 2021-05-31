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
        
        @Published var model = SubscriptionModel()
        
        @Published var subCategory: String = ""
        @Published var imageName: String = ""
        @Published var duration: String = ""
        @Published var remindMe: String? = nil
        
        @Published var isDataValid: Bool = true
        
        @Published var image: Image = Image("netflix_logo")
        
        
        @Published var selection1: Int = 0
        @Published var selection2: Int = 0
        
        private var cancellable = Set<AnyCancellable>()
        
        override func configureLinks() {
            super.configureLinks()
            
            Publishers.CombineLatest($selection1, $selection2)
                .sink(receiveValue: { (p1, p2) in
                    self.model.cycle.update(numberIndex: p1, periodIndex: p2)
                }).store(in: &cancellable)
            
//            Publishers.CombineLatest($model.name, $model.amount)
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
            let dbModel = Subscription(context: self.context)
            dbModel.update(model: model)
            do {
                try saveContext()
            } catch {
                fatalError("error saving context while creating an object")
            }
            return true
        }
    }
}

