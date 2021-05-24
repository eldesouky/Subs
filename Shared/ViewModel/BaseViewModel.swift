//
//  BaseViewModel.swift
//  Subs (iOS)
//
//  Created by Ahmed Magdi on 24/05/2021.
//

import SwiftUI
import Combine

class BaseViewModel: ObservableObject {
    
    init() {
        configureLinks()
    }
    
    func configureLinks() {}
}
