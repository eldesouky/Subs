//
//  DataManager.swift
//  DemoToDoList
//
//  Created by Alex Zarr on 2020-01-29.
//  Copyright © 2020 alexzarr. All rights reserved.
//

import Foundation
import CoreData

protocol DataManagerProtocol {
    func viewContext() -> NSManagedObjectContext
    
    func addItem(item: Subscription)
    func getItems() -> [Subscription]
}

class DataManager {
    static var shared: DataManager { DataManager() }
    var dbHelper: CoreDataHelper { CoreDataHelper.shared }
}


// MARK: - DataManagerProtocol
extension DataManager: DataManagerProtocol {
    func viewContext() -> NSManagedObjectContext {
        return dbHelper.context
    }
    
    func getItems() -> [Subscription] {
        //        let predicate = NSPredicate()//format: "uuid = %@", todo.id as CVarArg)
        let result: Result<[Subscription], Error> = dbHelper.fetch(Subscription.self)
        switch result {
        case .success(let items):
            return items
        case .failure(_):
            return []
        }
    }
    
    func addItem(item: Subscription) {
        dbHelper.create(item)
    }
}
