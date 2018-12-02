//
//  PropertyItem+CRUD.swift
//  CodyRela
//
//  Created by Neil Jain on 12/1/18.
//  Copyright © 2018 Neil Jain. All rights reserved.
//

import UIKit
import CoreData

extension PropertyItem {
    static func create(with name: String, price: String?, address: String?) -> Result<Bool> {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return .value(false) }
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "PropertyItem", in: context) else { return .value(false) }
        let propertyItem = PropertyItem.init(entity: entityDescription, insertInto: context)
        propertyItem.id = UUID()
        propertyItem.name = name
        propertyItem.price = price
        propertyItem.address = address
        
        do {
            try context.save()
            return .value(true)
        } catch {
            return .error(error)
        }
    }
    
    func add(referral: Referral) -> Result<Bool> {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return .value(false) }
        self.addToReferrals(referral)
        appDelegate.saveContext()
        return .value(true)
    }
}
