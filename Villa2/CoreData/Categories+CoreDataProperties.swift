//
//  Categories+CoreDataProperties.swift
//  Villa2
//
//  Created by nic Wanavit on 3/25/20.
//  Copyright © 2020 tenxor. All rights reserved.
//
//

import Foundation
import CoreData


extension Categories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categories> {
        return NSFetchRequest<Categories>(entityName: "Categories")
    }

    @NSManaged public var categoryList: Data?
    public var decodedCategoryList:ProductCategory? {
        get {
            if let data = categoryList{
                return decodeData(responseType: ProductCategory.self, data: data)
            } else {
                debugPrint("categoryList is empty")
                return nil
            }
        }
        set(inputData) {
            if let data = encodeData(data: inputData){
                self.categoryList = data
                debugPrint("categories written to core data")
            } else {
                debugPrint("encodingDataFailed")
            }
        }
    }

}
