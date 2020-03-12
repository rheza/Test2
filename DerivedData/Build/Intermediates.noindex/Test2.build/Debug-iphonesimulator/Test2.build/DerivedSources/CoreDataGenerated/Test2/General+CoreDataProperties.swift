//
//  General+CoreDataProperties.swift
//  
//
//  Created by Rheza Pahlevi on 12/03/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension General {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<General> {
        return NSFetchRequest<General>(entityName: "General")
    }

    @NSManaged public var activityDate: Date?
    @NSManaged public var activityType: String?
    @NSManaged public var notes: String?
    @NSManaged public var place: String?
    @NSManaged public var timeStart: Date?
    @NSManaged public var timeStop: Date?
    @NSManaged public var owner: Customer?

}
