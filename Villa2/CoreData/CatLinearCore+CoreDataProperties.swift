//
//  CatLinearCore+CoreDataProperties.swift
//  Villa2
//
//  Created by nic Wanavit on 3/31/20.
//  Copyright © 2020 tenxor. All rights reserved.
//
//

import Foundation
import CoreData


extension CatLinearCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CatLinearCore> {
        return NSFetchRequest<CatLinearCore>(entityName: "CatLinearCore")
    }

    @NSManaged public var id: Int16
    @NSManaged public var parentId: Int16
    @NSManaged public var name: String?
    @NSManaged public var position: Int16
    @NSManaged public var level: Int16
    @NSManaged public var children: String?
    @NSManaged public var includeInMenu: Bool

}
