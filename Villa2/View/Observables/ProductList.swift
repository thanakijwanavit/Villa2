//
//  ProductDataSource.swift
//  villaEcommerce
//
//  Created by nic Wanavit on 1/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation

class ProductList: ObservableObject {
    @Published var products:[ProductRaw]
    
    
    init(products: [ProductRaw]) {
        self.products = products
    }
    
    var cart:[ProductRaw] {
        let cartProducts = self.products.filter { (product) -> Bool in
//            var mutableProduct = product
            return product.isInCart
        }
        return cartProducts
    }
    
    func getQuantityInCart(sku:SKU)->Int {
        return 0
//        if let productID = self.findBySku(sku: sku){
//            return self.products[productID].quantityInCart
//        } else {
//            debugPrint("error in file Productlist, Cant find product sku:\(sku) in the product list using function getQuantityInCart")
//            return 0
//        }
    }
    
    func setQuantityInCart(sku:SKU, quantity:Int){
        if let productID = self.findBySku(sku: sku){
            self.products[productID].quantityInCart = quantity
        } else {
            debugPrint("error in file Productlist, Cant find product sku:\(sku) in the product list using function setQuantityInCart")
        }
    }
    
    var cartTotal:Float {
        var sum:Float = 0
//        debugPrint("cart is :", self.cart)
        for product in self.cart {
            debugPrint("price is :", product.price,"quantity is :", product.quantityInCart)
            sum += product.price * Float(product.quantityInCart)
            debugPrint("sum is ", sum)
        }
        return sum
    }
    
    
//    var filteredProspects: [Prospect] {
//        switch filter {
//        case .none:
//            return prospects.people
//        case .contacted:
//            return prospects.people.filter { $0.isContacted }
//        case .uncontacted:
//            return prospects.people.filter { !$0.isContacted }
//        }
//    }
    
    func findProductBySku(sku:SKU)->ProductRaw?{
        if let productIndex = self.findBySku(sku: sku){
            return self.products[productIndex]
        } else {
            return nil
        }
    }
    
    func findProductsBySku(skus:[SKU])->[ProductRaw]{
        var productList:[ProductRaw] = []
        for sku in skus{
            if let product = self.findProductBySku(sku: sku){
                productList.append(product)
            }
        }
        return productList
        
    }
    
    
    func findBySku(sku:SKU)->Int?{
        if let index = self.products.firstIndex(where: { (selectedProduct) -> Bool in
            return selectedProduct.sku == sku
            }) {
            return index
            }
        debugPrint("error findBySku cant find product")
        return nil
    }
    
    func findBySkus(skus:[SKU])->[Int]{
        var productIDList:[Int] = []
        for sku in skus{
            if let productID = self.findBySku(sku: sku) {
                productIDList.append(productID)
            }
        }
        return productIDList
    }
}


class SampleProductList{
    static var productList:ProductList {
        get {
            return ProductList(products: self.products)
        }
        set (newValue){
            self.products = newValue.products
        }
    }
    static var products:[ProductRaw] =
        [
        ProductRaw(name: "Banana", image: #imageLiteral(resourceName: "Banana"), price: 50, sku: "221224869864295", category:"fruit", description:"blah blah jdshaflkhsafkldhsfkldhjlkhja dklhdalkjhklhkhahkfajhkahdf jkhlkhklhjkhklh jhkhklhklhklhjklh oituttuiott tiptiotiotoit [otpotpotoitoi tiotoiutoi", quantityInCart: 4),
        ProductRaw(name: "Apple", image: #imageLiteral(resourceName: "Apple"), price: 100, sku: "36596234234249", category:"fruit", description:"blah blah"),
        ProductRaw(name: "orange", image: #imageLiteral(resourceName: "orange"), price: 80, sku: "3896292432342369", category:"fruit", description:"blah blah"),
        ProductRaw(name: "pen", image: #imageLiteral(resourceName: "pen"), price: 80, sku: "3892335324234369", category:"fruit", description:"blah blah", isRecommended: true),
        ProductRaw(name: "pen", image: #imageLiteral(resourceName: "pen"), price: 80, sku: "38923532344369", category:"fruit", description:"blah blah", isRecommended: true),
        ProductRaw(name: "pen", image: #imageLiteral(resourceName: "pen"), price: 80, sku: "38925392369", category:"fruit", description:"blah blah", isRecommended: true),
        ProductRaw(name: "pen", image: #imageLiteral(resourceName: "pen"), price: 80, sku: "3896322369", category:"fruit", description:"blah blah", isRecommended: true),
        ProductRaw(name: "pen", image: #imageLiteral(resourceName: "pen"), price: 80, sku: "3852339692369", category:"fruit", description:"blah blah", isRecommended: true),
        ProductRaw(name: "pen", image: #imageLiteral(resourceName: "pen"), price: 80, sku: "387435692369", category:"fruit", description:"blah blah", isRecommended: true),
        ProductRaw(name: "Apple", image: #imageLiteral(resourceName: "Apple"), price: 100, sku: "3653734249", category:"fruit", description:"blah blah"),
        ProductRaw(name: "Apple", image: #imageLiteral(resourceName: "Apple"), price: 100, sku: "36594754249", category:"fruit", description:"blah blah"),
        ProductRaw(name: "Apple", image: #imageLiteral(resourceName: "Apple"), price: 100, sku: "3659374534249", category:"fruit", description:"blah blah"),
        ProductRaw(name: "Apple", image: #imageLiteral(resourceName: "Apple"), price: 100, sku: "36596475249", category:"fruit", description:"blah blah"),
        ProductRaw(name: "Apple", image: #imageLiteral(resourceName: "Apple"), price: 100, sku: "36596374249", category:"fruit", description:"blah blah"),
        ProductRaw(name: "Apple", image: #imageLiteral(resourceName: "Apple"), price: 100, sku: "3659374249", category:"fruit", description:"blah blah"),
        ProductRaw(name: "Apple", image: #imageLiteral(resourceName: "Apple"), price: 100, sku: "365375434249", category:"fruit", description:"blah blah", quantityInCart: 4)
        ]
}
