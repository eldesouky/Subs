//
//  NewSubView+ViewModel.swift
//  Subs (iOS)
//
//  Created by Ahmed Magdi on 24/05/2021.
//

import SwiftUI
import Combine
import CoreData

extension NewSubView {
    class ViewModel : BaseViewModel {
        
        @Published var name: String = ""
        @Published var subDescription: String = ""
        @Published var subCategory: String = ""
        @Published var imageName: String = ""
        @Published var amount: Double = 0.0
        @Published var color: Color = Color.red
        @Published var firstBillDate: Date = Date()
        @Published var duration: String = ""
        @Published var remindMe: String? = nil
        
        @Published var currency: String = Locale.current.currencySymbol ?? ""
        
        @Published var isDataValid: Bool = true
              
        @Published var image: Image = Image("netflix_logo")
        
        @State var model = SubscriptionModel()
        
        override func configureLinks() {
            super.configureLinks()
            
//            Publishers.CombineLatest($name, $amount)
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
            Subscription.createDummy(context: context)
            do {
                try context.save()
            } catch {
                fatalError("error saving context while creating an object")
            }
            return true
        }
    }
}

