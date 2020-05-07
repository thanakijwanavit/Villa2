//
//  MagentoCodables.swift
//  VillaCoreData
//
//  Created by nic Wanavit on 3/22/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import CoreData

struct ProductCodable: Decodable {
    let id: Int
    let sku: String
    let name: String
    let attributeSetId: Int
    let price: Float
    let status: Int
    let visibility: Int
    let typeId: String
    let createdAt: String
    let UpdatedAt: String
//    let productLinks: [QuantumValue?]
//    let tierPrices: [String]
    let customAttributes:[CustomProductAttributes]
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case sku
        case name
        case attributeSetId = "attribute_set_id"
        case price
        case status
        case visibility
        case typeId = "type_id"
        case createdAt = "created_at"
        case UpdatedAt = "updated_at"
//        case productLinks = "product_links"
//        case tierPrices = "tier_prices"
        case customAttributes = "custom_attributes"
    }
    
    
    var toProductRaw:ProductRaw{
        let categoryIds = customAttributes.first { (customProductAttributes) -> Bool in
            return customProductAttributes.attributeCode == "category_ids"
            }?.value.listValue
        
        let metaKeywords = customAttributes.first { (customProductAttributes) -> Bool in
            return customProductAttributes.attributeCode == "meta_keyword"
            }?.value.stringValue
        
        let specialPrice = customAttributes.first { (customProductAttributes) -> Bool in
            return customProductAttributes.attributeCode == "special_price"
            }?.value.stringValue?.floatValue
        
        let imageUrl = customAttributes.first { (customProductAttributes) -> Bool in
            return customProductAttributes.attributeCode == "meta_keyword"
            }?.value.stringValue
        
        let description = customAttributes.first { (customProductAttributes) -> Bool in
            return customProductAttributes.attributeCode == "short_description"
            }?.value.stringValue
        
        
        return ProductRaw(name: name, image: #imageLiteral(resourceName: "AllLogo"), price: price, sku: sku, category: nil, categoryIds: categoryIds, description: description, isFavourite: false, isRecommended: false, isInHistory: false, imageURL: imageUrl, rankingScore: 0.00, metaKeywords: metaKeywords, specialPrice: specialPrice)
    }
    
    func toProductCore(context:NSManagedObjectContext,firstRun:Bool)->ProductCore{
//        debugPrint("price is:", self.price)
        if firstRun {
            return createNewProductCore(context: context)
        }else{
            if let product = checkIfProductExist(context: context, sku: self.sku){
                updateProductCore(productCore: product)
                return product
            } else {
                return createNewProductCore(context: context)
            }
        }
        
        
    }
    
    func createNewProductCore(context:NSManagedObjectContext)->ProductCore{
        let productCore = ProductCore(context: context)
        mergeProductCore(productCore: productCore)
        
        if let url = self.customAttributes.first(where: { (ca) -> Bool in
        return ca.attributeCode == "image"
        })?.value.stringValue {
            productCore.addImage(url: url)
        } else {
            ErrorCount.addRequestError(topic: "imageUrl new product", number: 1)
        }
        
        return productCore
    }
    
    func updateProductCore(productCore: ProductCore){
        self.mergeProductCore(productCore: productCore)

    }
    func getCustomStringAttributes(attName:String)->String?{
        if let stringValue = self.customAttributes.first(where: { (ca) -> Bool in
                return ca.attributeCode == attName
                })?.value.stringValue {
                    return stringValue
                } else {
            //record error in Errorcount
            ErrorCount.addRequestError(topic: attName, number: 1)
                    return nil
                }
    }
    
    func getCustomListAttributes(attName:String)->[String]?{
        if let listValue = self.customAttributes.first(where: { (ca) -> Bool in
                return ca.attributeCode == attName
                })?.value.listValue {
//                    debugPrint(listValue)
                    return listValue
                } else {
            //record error in Errorcount
                    ErrorCount.addRequestError(topic: attName, number: 1)
//                    ErrorCount.requestErrorCount.updateValue(ErrorCount.requestErrorCount[attName,default: 0] + 1, forKey: attName)
                    return nil
                }
    }
    
    func mergeProductCore(productCore: ProductCore){
        productCore.name = self.name
        productCore.sku = self.sku
        productCore.price = Int16(ceil(self.price) > Float(Int16.max) ? Float(0) : ceil(self.price))
        
        //update url
        if let url = getCustomStringAttributes(attName: "image"){
            productCore.addImage(url: url)
        }
        if let description = getCustomStringAttributes(attName: "short_description"){
            productCore.productDescription = description
        }
        if let metaKeywords = getCustomStringAttributes(attName: "meta_keyword"){
            productCore.metaKeywords = metaKeywords
        }
        if let longDescription = getCustomStringAttributes(attName: "description"){
            productCore.longDescription = longDescription
        }
        if let productCatId = getCustomListAttributes(attName: "category_ids"){
            productCore.categoryIds = productCatId
            let catLen = productCatId.count
            for catId in 0..<catLen {
                switch catId {
                case 0:
                    productCore.cat1 = productCatId[catId]
                case 1:
                    productCore.cat2 = productCatId[catId]
                case 2:
                    productCore.cat3 = productCatId[catId]
                case 3:
                    productCore.cat4 = productCatId[catId]
                default:
                    break
                }
            }
        }
    }
}

struct CustomProductAttributes:Decodable{
    let attributeCode: String
    let value: QuantumValue
    enum CodingKeys: String, CodingKey {
        case attributeCode = "attribute_code"
        case value
    }
}


struct ProductsCodable: Decodable {
    let item:[ProductCodable]
    enum CodingKeys: String, CodingKey {
        case item = "items"
    }
}

enum QuantumValue: Decodable {

    case int(Int), string(String), array([String]), dictionary([String:String])

    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }

        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        
        if let array = try? decoder.singleValueContainer().decode([String].self){
            self = .array(array)
            return
        }
        
        if let dictionary = try? decoder.singleValueContainer().decode([String:String].self){
            self = .dictionary(dictionary)
            return
        }

        throw QuantumError.missingValue
    }

    enum QuantumError:Error {
        case missingValue
    }
    
    var intValue : Int? {
        guard case .int(let num) = self else { return nil }
        return num
    }

    var stringValue : String? {
        guard case .string(let string) = self else { return nil }
        return string
    }
    
    var listValue : [String]? {
        guard case .array(let array) = self else { return nil }
        return array
    }
}



struct MagentoError: Codable {
    let errorMessage: String
//    let parameters: MagentoErrorParameters
    
    enum CodingKeys: String, CodingKey {
        case errorMessage = "message"
//        case parameters = "parameters"
    }
}

extension MagentoError: LocalizedError {
    var errorDescription: String? {
        return errorMessage
    }
}





