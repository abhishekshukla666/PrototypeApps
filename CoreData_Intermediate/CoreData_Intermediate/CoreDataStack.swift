//
//  CoreDataStack.swift
//  CoreData_Intermediate
//
//  Created by Abhishek on 21/08/18.
//  Copyright © 2018 AbhishekShukla. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {
    
    static let sharedInstance = CoreDataStack()
    private override init() { }
    
    static let moduleName = "myDevices"
    
    func saveMainContext () {
        guard managedObjectContext.hasChanges || privateManagedObjectContext.hasChanges else { return }
        managedObjectContext.performAndWait {
            do {
                try managedObjectContext.save()
            } catch let error {
                fatalError("Error saving main managed object context: \(error)")
            }
        }
        
        privateManagedObjectContext.perform {
            do {
                try self.privateManagedObjectContext.save()
            } catch let error {
                fatalError("Error saving main managed object context: \(error)")
            }
        }
    }
    
    lazy var managedObjectModel: NSManagedObjectModel? = {
        guard let modelUrl = Bundle.main.url(forResource: CoreDataStack.moduleName, withExtension: "momd") else { return nil }
        let model = NSManagedObjectModel(contentsOf: modelUrl)
        return model
    }()
    
    lazy var appDocumentDirectory: URL? = {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else { return nil }
        return url
    }()
    
    lazy var persistanceStoreCoordinate: NSPersistentStoreCoordinator? = {
        guard let managedObjectModel = managedObjectModel else { return nil }
        guard let applicationDirectory = appDocumentDirectory else { return nil }
        let coordinate = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let persistanceStoreUrl = applicationDirectory.appendingPathComponent("\(CoreDataStack.moduleName).sqlite")
        do {
            try coordinate.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistanceStoreUrl, options: [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true])
        } catch let error {
            print("Persistance store error: \(error)")
        }
        return coordinate
    }()
    
    private lazy var privateManagedObjectContext: NSManagedObjectContext = {
        let moc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        moc.persistentStoreCoordinator = persistanceStoreCoordinate
        return moc
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = privateManagedObjectContext
        return managedObjectContext
    }()
}
