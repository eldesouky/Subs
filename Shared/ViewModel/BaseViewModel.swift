//
//  BaseViewModel.swift
//  Subs (iOS)
//
//  Created by Ahmed Magdi on 24/05/2021.
//

import SwiftUI
import Combine
import CoreData

class BaseViewModel: ObservableObject {
    var context: NSManagedObjectContext
    
    init() {
        self.context = PersistenceController.isPreviewing ? PersistenceController.preview.container.viewContext : PersistenceController.shared.container.viewContext
        configureLinks()
    }
    
//    init() {
//        configureLinks()
//    }
    
    func configureLinks() {}
}
