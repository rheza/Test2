//
//  Customer+CoreDataProperties.swift
//  
//
//  Created by Rheza Pahlevi on 13/03/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var activityDate: Date?
    @NSManaged public var activityType: String?
    @NSManaged public var birthday: Date?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var place: String?
    @NSManaged public var planToStart: Date?
    @NSManaged public var price: Int64
    @NSManaged public var productCode: String?
    @NSManaged public var productType: String?
    @NSManaged public var reason: String?
    @NSManaged public var termPlan: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var timeStart: Date?
    @NSManaged public var timeStop: Date?

}
