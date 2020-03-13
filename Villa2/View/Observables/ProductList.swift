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
            var mutableProduct = product
            return mutableProduct.isInCart
        }
        return cartProducts
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
    
    func findBySku(sku:SKU)->ProductRaw{
        if let index = self.products.firstIndex(where: { (selectedProduct) -> Bool in
            return selectedProduct.sku == sku
            }) {
            return self.products[index]
            }
        return products[0]
    }
    
    func findBySkus(skus:[SKU])->[ProductRaw]{
        var productList:[ProductRaw] = []
        for sku in skus{
            productList.append(self.findBySku(sku: sku))
        }
        return productList
    }
}


class SampleProductList{
    static var products:[ProductRaw] =
        [
        ProductRaw(name: "Banana", image: #imageLiteral(resourceName: "Banana"), price: 50, sku: "221224869864295", category:"fruit", description:"blah blah jdshaflkhsafkldhsfkldhjlkhja dklhdalkjhklhkhahkfajhkahdf jkhlkhklhjkhklh jhkhklhklhklhjklh oituttuiott tiptiotiotoit [otpotpotoitoi tiotoiutoi"),
        ProductRaw(name: "Apple", image: #imageLiteral(resourceName: "Apple"), price: 100, sku: "365962359883659", category:"fruit", description:"blah blah"),
        ProductRaw(name: "orange", image: #imageLiteral(resourceName: "orange"), price: 80, sku: "389629639692369", category:"fruit", description:"blah blah", isInCart: true),
        ProductRaw(name: "pen", image: #imageLiteral(resourceName: "pen"), price: 80, sku: "389629639692369", category:"fruit", description:"blah blah", isRecommended: true, isInCart: true),
        ProductRaw(name: "pen", image: #imageLiteral(resourceName: "pen"), price: 80, sku: "389629639692369", category:"fruit", description:"blah blah", isRecommended: true),
        ProductRaw(name: "pen", image: #imageLiteral(resourceName: "pen"), price: 80, sku: "389629639692369", category:"fruit", description:"blah blah", isRecommended: true),
        ProductRaw(name: "pen", image: #imageLiteral(resourceName: "pen"), price: 80, sku: "389629639692369", category:"fruit", description:"blah blah", isRecommended: true, isInCart: true),
        ProductRaw(name: "pen", image: #imageLiteral(resourceName: "pen"), price: 80, sku: "389629639692369", category:"fruit", description:"blah blah", isRecommended: true),
        ProductRaw(name: "pen", image: #imageLiteral(resourceName: "pen"), price: 80, sku: "389629639692369", category:"fruit", description:"blah blah", isRecommended: true)
        ]
}
