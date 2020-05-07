//
//  ProductCore+CoreDataProperties.swift
//  Villa2
//
//  Created by nic Wanavit on 4/2/20.
//  Copyright © 2020 tenxor. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductCore> {
        return NSFetchRequest<ProductCore>(entityName: "ProductCore")
    }

    @NSManaged public var categoryIds: [String]?
    @NSManaged public var imageData: Data?
    @NSManaged public var imageUrl: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var isInCart: Bool
    @NSManaged public var isInHistory: Bool
    @NSManaged public var isRecommended: Bool
    @NSManaged public var longDescription: String?
    @NSManaged public var metaKeywords: String?
    @NSManaged public var name: String?
    @NSManaged public var numberInCart: Int16
    @NSManaged public var price: Int16
    @NSManaged public var productDescription: String?
    @NSManaged public var rankingScore: Float
    @NSManaged public var sku: String?
    @NSManaged public var cat1: String?
    @NSManaged public var cat2: String?
    @NSManaged public var cat3: String?
    @NSManaged public var cat4: String?

}
