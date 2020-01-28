//
//  Item+CoreDataProperties.swift
//  CoredataRelationship
//
//  Created by Md. Mehedi Hasan on 28/1/20.
//  Copyright © 2020 Md. Mehedi Hasan. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var owner: Person?

}
