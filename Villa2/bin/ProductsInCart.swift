////
////  ProductsInCart.swift
////  villaEcommerce
////
////  Created by nic Wanavit on 1/14/20.
////  Copyright © 2020 tenxor. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class ProductsInCart{
//    
//    static var productList:[ProductStorage] = []
//    static func totalPrice()->Float{
//        var total:Float = 0
//        for product in ProductsInCart.productList {
//            total += product.totalPrice
//        }
//        return total
//    }
//    
//    static func addNewProductToCart(productToAdd:ProductRaw, quantity:Int){
//        let newProductStorage = ProductStorage(product: productToAdd, quantity: quantity)
//        self.productList.append(newProductStorage)
//    }
//    
//    static func removeFromCart(sku:String, quantity:Int){
//        if let index = self.productList.firstIndex(where: { (selectedProduct) -> Bool in
//            return selectedProduct.product.sku == sku
//        }){
//            if quantity >= self.productList[index].quantity {
//                self.productList.remove(at: index)
//            } else {
//                self.productList[index].quantity -= quantity
//            }
//        } else {
//            debugPrint("product not in the cart",self.productList)
//        }
//    }
//    
//}
//struct ProductStorage{
//    let product:ProductRaw
//    var quantity:Int
//    var totalPrice : Float {
//        get {
//            product.price * Float(quantity)
//        }
//    }
//}
