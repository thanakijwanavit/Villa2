//
//  Category.swift
//  Villa2
//
//  Created by nic Wanavit on 3/24/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
class SampleCategory{
    static var category = ProductCategory(id: 1, parentId: 1, name: "mock", isActive: true, position: 1, level: 1, productCount: 1, childrenData: [ProductCategory(id: 1, parentId: 1, name: "mock", isActive: true, position: 1, level: 1, productCount: 1, childrenData: [ProductCategory(id: 1, parentId: 1, name: "mock", isActive: true, position: 1, level: 1, productCount: 1, childrenData: [])])])
}
class SubCategoryList{
    
}
///// product cat
public struct ProductCategory: Codable, Hashable{
    let id: Int
    let parentId: Int
    let name: String
    let isActive: Bool
    let position: Int
    let level: Int
    let productCount: Int
    let childrenData:[ProductCategory]
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    enum CodingKeys: String, CodingKey{
        case id
        case parentId = "parent_id"
        case name
        case isActive = "is_active"
        case position
        case level
        case productCount = "product_count"
        case childrenData = "children_data"
    }
}

public struct ProductCatLinearizedCodable: Codable, Hashable{
    let id: Int
    let parentId: Int
    let name: String
    let position: Int
    let level: Int
    let children: String
    let includeInMenu: Bool
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    enum CodingKeys: String, CodingKey{
        case id
        case parentId = "parent_id"
        case name
        case position
        case level
        case children
        case includeInMenu = "include_in_menu"
    }
}

public struct ProductCatLinearizedCodableContainer: Codable{
    let items: [ProductCatLinearizedCodable]
}

class ProductCategoryList: ObservableObject{
    @Published var products: ProductCategory
    
    init(productCategory:ProductCategory) {
        self.products = productCategory
    }
}

