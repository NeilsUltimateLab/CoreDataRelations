//
//  Referral+CoreDataProperties.swift
//  CodyRela
//
//  Created by Neil Jain on 12/1/18.
//  Copyright © 2018 Neil Jain. All rights reserved.
//
//

import Foundation
import CoreData


extension Referral {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Referral> {
        return NSFetchRequest<Referral>(entityName: "Referral")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var interestedIn: Set<PropertyItem>?

}

// MARK: Generated accessors for interestedIn
extension Referral {

    @objc(addInterestedInObject:)
    @NSManaged public func addToInterestedIn(_ value: PropertyItem)

    @objc(removeInterestedInObject:)
    @NSManaged public func removeFromInterestedIn(_ value: PropertyItem)

    @objc(addInterestedIn:)
    @NSManaged public func addToInterestedIn(_ values: NSSet)

    @objc(removeInterestedIn:)
    @NSManaged public func removeFromInterestedIn(_ values: NSSet)

}
