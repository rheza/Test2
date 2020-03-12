//
//  Customer+CoreDataProperties.swift
//  
//
//  Created by Rheza Pahlevi on 12/03/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var birthday: Date?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var ownerGeneral: General?
    @NSManaged public var ownerProductA: ProductA?
    @NSManaged public var ownerProductB: ProductB?

}
