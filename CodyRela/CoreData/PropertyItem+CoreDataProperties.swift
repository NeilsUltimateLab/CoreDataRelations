//
//  PropertyItem+CoreDataProperties.swift
//  CodyRela
//
//  Created by Neil Jain on 12/1/18.
//  Copyright © 2018 Neil Jain. All rights reserved.
//
//

import Foundation
import CoreData


extension PropertyItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PropertyItem> {
        return NSFetchRequest<PropertyItem>(entityName: "PropertyItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var address: String?
    @NSManaged public var referrals: Set<PropertyItem>?

}

// MARK: Generated accessors for referrals
extension PropertyItem {

    @objc(addReferralsObject:)
    @NSManaged public func addToReferrals(_ value: Referral)

    @objc(removeReferralsObject:)
    @NSManaged public func removeFromReferrals(_ value: Referral)

    @objc(addReferrals:)
    @NSManaged public func addToReferrals(_ values: NSSet)

    @objc(removeReferrals:)
    @NSManaged public func removeFromReferrals(_ values: NSSet)

}
