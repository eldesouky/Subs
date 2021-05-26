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
        @Published var image: UIImage = UIImage(named: "netflix_logo_2")!
        @Published var price: String = ""
        @Published var currency: String = ""
        @Published var color: Color = Color.red
        @Published var firstBillDate: Date = Date()
        @Published var duration: String = ""
        @Published var remindMe: String? = nil
        
        @Published var isDataValid: Bool = false
        
        @State var subItem: Subscription
        
        override init(context: NSManagedObjectContext) {
            subItem = Subscription(context: context)
            super.init(context: context)
        }
        
        override func configureLinks() {
            super.configureLinks()
            
            Publishers.CombineLatest($name, $price)
                .map { StyleSheet.validate(input: $0) && StyleSheet.validate(input: $1)}
                .assign(to: &$isDataValid)
        }
        
        // MARK: - Validations
        
        
        func storeItem() {
            if isDataValid {
                do {
                    try context.save()
                } catch {
                    fatalError("error saving context while creating an object")
                }
            }
        }
    }
}

