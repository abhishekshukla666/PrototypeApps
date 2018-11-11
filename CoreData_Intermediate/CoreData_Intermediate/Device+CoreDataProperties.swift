//
//  Device+CoreDataProperties.swift
//  CoreData_Intermediate
//
//  Created by Abhishek Shukla on 21/08/18.
//  Copyright © 2018 AbhishekShukla. All rights reserved.
//
//

import Foundation
import CoreData


extension Device {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }

    @NSManaged public var devicePurchaseDate: NSDate?
    @NSManaged public var deviceType: String?
    @NSManaged public var deviceName: String?
    @NSManaged public var owner: Person?

}
