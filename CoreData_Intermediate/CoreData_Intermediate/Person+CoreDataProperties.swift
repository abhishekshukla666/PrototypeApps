//
//  Person+CoreDataProperties.swift
//  CoreData_Intermediate
//
//  Created by Abhishek Shukla on 21/08/18.
//  Copyright © 2018 AbhishekShukla. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var age: Int16
    @NSManaged public var password: String?
    @NSManaged public var devices: NSSet?

}

// MARK: Generated accessors for devices
extension Person {

    @objc(addDevicesObject:)
    @NSManaged public func addToDevices(_ value: Device)

    @objc(removeDevicesObject:)
    @NSManaged public func removeFromDevices(_ value: Device)

    @objc(addDevices:)
    @NSManaged public func addToDevices(_ values: NSSet)

    @objc(removeDevices:)
    @NSManaged public func removeFromDevices(_ values: NSSet)

}
