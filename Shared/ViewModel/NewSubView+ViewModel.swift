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
        
        override func configureLinks() {
            super.configureLinks()
            
            Publishers.CombineLatest($name, $price)
                .map { StyleSheet.validate(input: $0) && StyleSheet.validate(input: $1)}
                .assign(to: &$isDataValid)
        }
        
        // MARK: - Validations
        
        
        func storeItem() {
            if isDataValid {
                
            }
        }
    }
}

