//
//  ProductB+CoreDataProperties.swift
//  
//
//  Created by Rheza Pahlevi on 11/03/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension ProductB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductB> {
        return NSFetchRequest<ProductB>(entityName: "ProductB")
    }

    @NSManaged public var activityDate: Date?
    @NSManaged public var activityType: String?
    @NSManaged public var notes: String?
    @NSManaged public var price: Int64
    @NSManaged public var productCode: String?
    @NSManaged public var termPlan: String?
    @NSManaged public var timeStart: Date?
    @NSManaged public var timeStop: Date?
    @NSManaged public var owner: Customer?

}
