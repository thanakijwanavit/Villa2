//
//  GeneralFunctions.swift
//  Villa2
//
//  Created by nic Wanavit on 3/25/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import CoreData
import Foundation
import UIKit
import KingfisherSwiftUI
import SwiftUI

func decodeData<ResponseType: Decodable>(responseType: ResponseType.Type, data:Data)->ResponseType?{
    
    let decoder = JSONDecoder()
    do {
        let responseObject = try decoder.decode(ResponseType.self, from: data)
        return responseObject
    } catch {
        debugPrint("error parsing object", error)
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            debugPrint("json decoded is", json)
            return nil
        } catch {
            debugPrint("data is not json", error)
            return nil
        }
    }
}

func encodeData<ResponseType: Encodable>(data: ResponseType)->Data?{
    
    let encoder = JSONEncoder()
    do {
        let data = try encoder.encode(data)
        return data
    } catch {
        debugPrint("failed to encode data", error)
        return nil
    }
}

func fetchCatFromCoreData(context:NSManagedObjectContext)->Categories?{
    let catFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
    do {
        let fetchedCat = try context.fetch(catFetchRequest) as! [Categories]
        if let firstItem = fetchedCat.first {
            debugPrint("core data category fetched")
            return firstItem
        } else {
            debugPrint("core data category is empty")
            return nil
        }
    } catch {
        debugPrint("Failed to fetch cat from coreData: \(error)")
        return nil
    }
}



func checkIfProductExist(context:NSManagedObjectContext ,sku: String) -> ProductCore? {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCore")
    fetchRequest.fetchLimit =  1
    fetchRequest.predicate = NSPredicate(format: "sku == %@" ,sku)
//    fetchRequest.predicate = NSPredicate(format: "type == %@" ,type)
    do {
        let fetchedProduct = try context.fetch(fetchRequest) as! [ProductCore]
//        debugPrint("fetch successful")
        return fetchedProduct.first
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo), maybe product is not in coredata")
        return nil
    }
}



//Variables
let IMAGE_PLACEHOLDER = "VillaPlaceholder"






class ImageManipulation{
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage ?? UIImage(named: "VillaPlaceholder")!
    }
}

class ErrorCount{
    static var requestErrorCount:[String:Int] = [:]
    static func addRequestError(topic:String, number:Int){
        if ErrorCount.requestErrorCount[topic] == nil {
            ErrorCount.requestErrorCount[topic] = 0
        }
        ErrorCount.requestErrorCount.updateValue(ErrorCount.requestErrorCount[topic,default: 0] + number, forKey: topic)
    }
    static var productImageErrorCount = 0
//    static var 
}

class CoreDataFunctions{
    class func saveContext(){
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}

class ImagePlaceholder {
    struct productPlaceholderImage: View {
        var body: some View {
            KFImage(URL(string: "https://villa-images-sg.s3-ap-southeast-1.amazonaws.com/villaPlaceholder.png")!)
            .resizable()
            .renderingMode(.original)
            .scaledToFit()
        }
    }
}
