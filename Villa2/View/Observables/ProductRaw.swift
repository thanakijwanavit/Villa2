//
//  Product.swift
//  villaEcommerce
//
//  Created by nic Wanavit on 1/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import UIKit

struct ProductRaw:  Hashable{
    
    
    let name:String
    var image:UIImage{
        didSet {
            if self.image != #imageLiteral(resourceName: "Apple"){
                NotificationCenter.default.post(name: Notification.Name("download\(self.sku)"), object: nil)
            }
        }
    }
    let price:Float
    let sku:String
//    var id = UUID()
    let category:String?
    var categoryIds:[String]? = []
    let description:String?
    var isFavourite:Bool = false
    var isRecommended:Bool = false
    var isInHistory:Bool = false
    var imageURL:String?
    var rankingScore:Float = 0
    
    var metaKeywords: String?
    var specialPrice:Float?
    
    var quantityInCart:Int = 0

    var priceDescription : String {
        get{
            "฿ \(String(format: "%.2f" ,price))"
        }
        
    }
    var isInCart:Bool {
        return self.quantityInCart > 0
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(sku)
    }
}
