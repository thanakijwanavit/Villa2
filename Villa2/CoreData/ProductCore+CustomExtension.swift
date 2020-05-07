//
//  ProductCore+CustomExtension.swift
//  Villa2
//
//  Created by nic Wanavit on 3/31/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI
import KingfisherSwiftUI
import CoreData
// all the extensions

extension ProductCore{
    
    public var quantityInCart: Int {
                get {
                    return Int(self.numberInCart)
                }
                set {
                    self.numberInCart = Int16(newValue)
                    self.updateCart()
                    
                }
            }
        
    public var image:UIImage {
        get {
            if let imageUrl = self.imageUrl{
                if let data = self.imageData, let image = UIImage(data: data),UIImage(data: data) != UIImage(named: IMAGE_PLACEHOLDER){
                    debugPrint("image exist in coredata, returning")
                    return image
                } else {
                    debugPrint("imageData is blank or placeholder, returning placeholder")
                    return UIImage(named: IMAGE_PLACEHOLDER)!
                }
            } else {
                debugPrint("imageUrl is blank, returning placeholder")
                return UIImage(named: IMAGE_PLACEHOLDER)!
            }
//            debugPrint("Unknown image download error, returning placeholder")
//            return UIImage(named: IMAGE_PLACEHOLDER)!
        }
        set {
            self.imageData = newValue.pngData()
        }
    }
    
    public var priceDescription : String {
        get{
//            debugPrint("price is", self.price)
//            debugPrint("price description is", String(format: "%.2f" ,Float(self.price)))
            return "฿ \(String(format: "%.2f" ,Float(self.price)))"
        }
        
    }
    
    func updateCart(){
        if self.numberInCart > 0 {
            self.isInCart = true
        } else {
            self.isInCart = false
        }
    }
    func addImage(url:String){
        self.imageUrl = url
        
    }
    
    public var wrappedUrl:URL {
        let endpoint = MagentoApi.Endpoints.image(self.sku ?? "villaHeader.png")
        if let url = endpoint.url {
            return url
        } else {
            //Placeholder please dont forget to edit
            return URL(string: "https://villa-images-sg.s3-ap-southeast-1.amazonaws.com/villaPlaceholder.png")!
        }
    }
    
    public var wrappedAlternativeUrl:URL {
        let endpoint = MagentoApi.Endpoints.alternativeImage(self.imageUrl ?? "villaHeader.png")
        if let url = endpoint.url {
            return url
        } else {
            //Placeholder please dont forget to edit
            return URL(string: "https://villa-images-sg.s3-ap-southeast-1.amazonaws.com/villaPlaceholder.png")!
        }
    }
    
    
    
    public var kfImage: some View {
        return KFImage(self.wrappedUrl)
            .placeholder{
                KFImage(self.wrappedAlternativeUrl)
                .placeholder{
                    ImagePlaceholder.productPlaceholderImage()
                }
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
            
            }
            .resizable()
            .renderingMode(.original)
            .scaledToFit()
    }
    

    
//    // get category
//    func category(){
//        let request: NSFetchRequest<ProductCore> = ProductCore.fetchRequest()
//        request.fetchLimit = 200
////        debugPrint("cat1 is \(cat1), cat2 is \(cat2)")
//        let cat1Predicate = NSPredicate(format: cat1.count > 0 ? "(cat1 LIKE[c] %@) OR (cat2 LIKE[c]  %@) OR (cat3 LIKE[c] %@) OR (cat4 LIKE[c] %@)":"TRUEPREDICATE", cat1,cat1,cat1,cat1)
//        let cat2Predicate = NSPredicate(format: cat2.count > 0 ? "(cat1 LIKE[c] %@) OR (cat2 LIKE[c]  %@) OR (cat3 LIKE[c] %@) OR (cat4 LIKE[c] %@)":"TRUEPREDICATE", cat2,cat2,cat2,cat2)
//        let searchPredicate = NSPredicate(format: filter.count > 0 ? "(name CONTAINS[c] %@) OR (metaKeywords CONTAINS[c] %@) ":"TRUEPREDICATE", filter.count > 0 ? filter:"*",filter.count > 0 ? filter:"*")
//
//        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [cat1Predicate, cat2Predicate,searchPredicate])
//        request.predicate = andPredicate
//        request.sortDescriptors = []
//    }
    
}
