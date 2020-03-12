//
//  ProductA+CoreDataProperties.swift
//  
//
//  Created by Rheza Pahlevi on 12/03/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension ProductA {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductA> {
        return NSFetchRequest<ProductA>(entityName: "ProductA")
    }

    @NSManaged public var activityDate: Date?
    @NSManaged public var activityType: String?
    @NSManaged public var productCode: String?
    @NSManaged public var reason: String?
    @NSManaged public var timeStart: Date?
    @NSManaged public var timeStop: Date?
    @NSManaged public var owner: Customer?

}
