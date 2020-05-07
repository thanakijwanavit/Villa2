//
//  S3GetProducts.swift
//  Villa2
//
//  Created by nic Wanavit on 3/27/20.
//  Copyright © 2020 tenxor. All rights reserved.
//
import CoreData
import Foundation
class S3Api{
    class func getProducts()->[ProductCodable]?{
        let endpoint = S3Api.Endpoints.products
        let url = endpoint.url
        let semaphore = DispatchSemaphore(value: 0)
        var products: [ProductCodable]?
        guard url != nil else {
            debugPrint("invalid url")
            return nil
        }
        
        debugPrint("getting products")
        S3Api.taskForGETS3(url: url!, responseType: [ProductCodable].self) { (p, e) in
            guard e == nil else {
                debugPrint("error fetching data", e?.localizedDescription ?? "")
                return
            }
            products = p
            semaphore.signal()
            debugPrint("api products response recieved")
        }
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return products
    }
    
    class func getProductRaws()->[ProductRaw]?{
        let productCodables = S3Api.getProducts()
        var productRaws:[ProductRaw] = []
        if let productCodables = productCodables{
            for productCodable in productCodables{
                productRaws.append(productCodable.toProductRaw)
            }
        }
        if productRaws.count > 1 {
            return productRaws
        } else {
            return nil
        }
    }
    
    class func getProductCores(context:NSManagedObjectContext)->[ProductCore]?{
        let productCodables = S3Api.getProducts()
        var productCores:[ProductCore] = []
        let isFirstRun = !UserDefaults.standard.bool(forKey: "firstProductCoreLoad")
        debugPrint("isFirstRun",isFirstRun)
        if let productCodables = productCodables{
            debugPrint("products have decoded successfully")
            for productCodable in productCodables{
                productCores.append(productCodable.toProductCore(context: context, firstRun: isFirstRun))
                if productCores.count.quotientAndRemainder(dividingBy: 1000).remainder == 0 {
//                    debugPrint("1000 products has been added")
                    do {
                        try context.save()
                        context.reset()
//                        debugPrint("context saved and reset")
                    } catch {
                        debugPrint("context save error")
                    }
                }
            }
        }
        debugPrint("error summary for products request",ErrorCount.requestErrorCount)
        do {
            try context.save()
            context.reset()
        } catch {
            debugPrint("saving error line 77 GetProductsCores")
        }
        if productCores.count > 1 {
            UserDefaults.standard.set(true, forKey: "firstProductCoreLoad")
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCore")
            do {
                let count = try context.count(for: fetchRequest)
                debugPrint("coredata has \(count) items")
            } catch {
                debugPrint("count error")
            }
            return productCores
        } else {
            return nil
        }
    }
    
    
    class func getCatLinear()->[ProductCatLinearizedCodable]?{
        let endpoint = S3Api.Endpoints.catList
        let url = endpoint.url
        let semaphore = DispatchSemaphore(value: 0)
        var cat: [ProductCatLinearizedCodable]?
        guard url != nil else {
            debugPrint("invalid url")
            return nil
        }
        
        debugPrint("getting products")
        S3Api.taskForGETS3(url: url!, responseType: ProductCatLinearizedCodableContainer.self) { (c, e) in
            guard e == nil else {
                debugPrint("error fetching data", e?.localizedDescription ?? "")
                return
            }
            if let c = c{
                cat = c.items
            } else {
                debugPrint("cat returned is nil")
            }
            semaphore.signal()
            debugPrint("api linearized cat response recieved")
        }
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return cat
    }
    
    
    
    
    
    enum Endpoints {
        static let base = "https://villa-products-sg.s3-ap-southeast-1.amazonaws.com/products.json"
        static let gzip = "https://d18ug7ix877nj9.cloudfront.net/products.gzip"
        static let catListUrl = "https://d18ug7ix877nj9.cloudfront.net/catList.json"
        
        case products
        case productsGzip
        case catList

        
            
        var stringValue: String {
                switch self {
                case .products: return Endpoints.base
                case .productsGzip: return Endpoints.gzip
                case .catList: return Endpoints.catListUrl
                }
            
            }
            
        var url: URL? {
            if let url = URL(string: stringValue) {
                return url
            } else {
                debugPrint("error parsing url", stringValue)
                return nil
            }
        }
    }
    
    
    class func taskForGETS3<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            debugPrint("api call to \(url) made")
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                completion(responseObject, nil)
            } catch {
                debugPrint("error parsing object", error)
                do {
                    let errorResponse = try decoder.decode(MagentoError.self, from: data) as Error
                    completion(nil, errorResponse)
                } catch {
                    debugPrint("error parsing error response", data)
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        debugPrint("json received", json)
                    } catch {
                        debugPrint("data is not json", error)
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
}
