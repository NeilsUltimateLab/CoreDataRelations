//
//  Referral+CRUD.swift
//  CodyRela
//
//  Created by Neil Jain on 12/1/18.
//  Copyright © 2018 Neil Jain. All rights reserved.
//

import UIKit
import CoreData

extension Referral {
    static func create(name: String) -> Result<Bool> {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return .value(false) }
        guard let description = NSEntityDescription.entity(forEntityName: "Referral", in: context) else {
            return .value(false)
        }
        let referral = Referral.init(entity: description, insertInto: context)
        referral.name = name
        referral.id = UUID()
        do {
            try context.save()
            return .value(true)
        } catch {
            return .error(error)
        }
    }
    
    func add(property: PropertyItem) -> Result<Bool> {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return .value(false) }
        self.addToInterestedIn(property)
        do {
            try context.save()
            return .value(true)
        } catch {
            return .error(error)
        }
    }
}
