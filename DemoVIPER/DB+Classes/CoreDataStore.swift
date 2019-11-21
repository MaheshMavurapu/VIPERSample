//
//  CoreDataStore.swift
//  DemoVIPER
//
//  Created by Mahesh Mavurapu on 21/11/19.
//  Copyright © 2019 Mahesh Mavurapu. All rights reserved.
//

import Foundation
import CoreData

// Core data manager
class CoreDataStore {
    // Singleton - Shared Instance
    static let sharedManager: CoreDataStore = CoreDataStore()
    
    // Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DemoVIPER")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // Managed Object Context
    lazy var managedObjectContext: NSManagedObjectContext? = {
        return persistentContainer.viewContext
    }()
    
    // Save to DataBase
    func saveContext () {
        if managedObjectContext!.hasChanges {
            do {
                try managedObjectContext?.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
