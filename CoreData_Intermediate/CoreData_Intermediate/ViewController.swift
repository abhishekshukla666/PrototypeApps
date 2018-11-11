//
//  ViewController.swift
//  CoreData_Intermediate
//
//  Created by Abhishek on 21/08/18.
//  Copyright © 2018 AbhishekShukla. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    let person = "Person"
    let device = "Device"
    
    lazy var coreDataStack = CoreDataStack.sharedInstance
    
    var fetchedResultController: NSFetchedResultsController<Person>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let context = coreDataStack.managedObjectContext
    
//        let fetchRequest = NSFetchRequest<Person>(entityName: person)
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
//        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//
//        guard let persons = fetchedResultController?.fetchedObjects else { return }
//        for person in persons {
//            print("Here is the fetch data: ")
//            print(person.name ?? "Name not found")
//            print(person.email ?? "Email Not found")
//            print(person.password ?? "Password not found")
//            print(person.age)
//            print("\n")
//
//            if let devices = person.devices as? Set<Device>, devices.count > 0 {
//                for device in devices {
//                    print("Printing Devices")
//                    print(device.deviceName ?? "Device Name Not found\n")
//                }
//            }
//        }
        
//        guard let entity = NSEntityDescription.entity(forEntityName: person, in: context) else { return }
//        let shiva = Person(entity: entity, insertInto: context)
//        shiva.name = "Abhishek Shukla"
//        shiva.email = "abhishek@gmail.com"
//        shiva.age = 28
//        shiva.password = "123456"
//
//        guard let entityDevice = NSEntityDescription.entity(forEntityName: device, in: context) else { return }
//        let samsung = Device(entity: entityDevice, insertInto: context)
//        samsung.deviceName = "note 5"
//        samsung.devicePurchaseDate = NSDate()
//        samsung.deviceType = "android"
//
//        let iPhone = Device(entity: entityDevice, insertInto: context)
//        iPhone.deviceName = "iPhone X"
//        iPhone.devicePurchaseDate = NSDate()
//        iPhone.deviceType = "iOS"
//
//        shiva.devices = NSSet(array: [samsung, iPhone])
//
//        coreDataStack.saveMainContext()
        
//        let fetchRequest = NSFetchRequest<Person>(entityName: person)
//        do {
//            let result = try context.fetch(fetchRequest)
//            for person in result {
//                print("Here is the fetch data: ")
//                print(person.name ?? "Name not found")
//                print(person.email ?? "Email Not found")
//                print(person.password ?? "Password not found")
//                print(person.age)
//                print("\n")
//
//                if let devices = person.devices as? Set<Device>, devices.count > 0 {
//                    for device in devices {
//                        print("Printing Devices")
//                        print(device.deviceName ?? "Device Name Not found\n")
//                    }
//                }
//            }
//        } catch let error {
//            print("Error in fetching the person: \(error)")
//        }
        
//        let fetchRequest = NSFetchRequest<Device>(entityName: device)
//        do {
//            let devices = try context.fetch(fetchRequest)
//            for device in devices {
//                print("Printing Devices")
//                print(device.deviceName ?? "Device name not found")
//                print(device.owner?.name ?? "Device Owner not found")
//            }
//        } catch let error {
//            print("Error Fetching the device: \(error)")
//        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

