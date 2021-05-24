//
//  CoreDataHelper.swift
//  DemoToDoList
//
//  Created by alex.zarr on 5/23/20.
//  Copyright © 2020 alexzarr. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelper: DBHelperProtocol {
    static let shared = CoreDataHelper()
    static var preview: CoreDataHelper = {
        let result = CoreDataHelper(inMemory: true)
        var count = 0
        
        let data: Result<[Subscription], Error> = result.fetch(Subscription.self)
        switch data {
        case .success(let items):
            count = items.count
        default:
            break
        }

        if count < 2 {
            for _ in 0..<2 {
                Subscription.createDummy(context: result.context)
            }
            do {
                try result.context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        return result
    }()
    
    typealias ObjectType = NSManagedObject
    typealias PredicateType = NSPredicate
    
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    init(inMemory: Bool = false) {
        self.inMemory = inMemory
    }
    
    lazy var inMemory: Bool = false
    
    
    // MARK: - Core Data
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        var container = NSPersistentCloudKitContainer(name: "Subs")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: -  DBHelper Protocol
    
    func create(_ object: NSManagedObject) {
        do {
            try context.save()
        } catch {
            fatalError("error saving context while creating an object")
        }
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate? = nil, limit: Int? = nil) -> Result<[T], Error> {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        if let limit = limit {
            request.fetchLimit = limit
        }
        do {
            let result = try context.fetch(request)
            return .success(result as? [T] ?? [])
        } catch {
            return .failure(error)
        }
    }
    
    func fetchFirst<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?) -> Result<T?, Error> {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        request.fetchLimit = 1
        do {
            let result = try context.fetch(request) as? [T]
            return .success(result?.first)
        } catch {
            return .failure(error)
        }
    }
    
    func update(_ object: NSManagedObject) {
        do {
            try context.save()
        } catch {
            fatalError("error saving context while updating an object")
        }
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
