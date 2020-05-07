//
//  MagentoApi.swift
//  Villa2
//
//  Created by nic Wanavit on 3/24/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

//import Foundation
//
//  MagentoApi.swift
//  VillaCoreData
//
//  Created by nic Wanavit on 3/22/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI
import Kingfisher
class MagentoApi{
    
    
    class func getProducts(page:Int)->ProductsCodable?{
        let endpoint = MagentoApi.Endpoints.products(String(page))
        let url = endpoint.url
        let semaphore = DispatchSemaphore(value: 0)
        var products: ProductsCodable?
        guard url != nil else {
            debugPrint("invalid url")
            return nil
        }
        
        MagentoApi.taskForGETMagento(url: url!, responseType: ProductsCodable.self) { (p, e) in
            guard e == nil else {
                debugPrint("error fetching data", e?.localizedDescription ?? "")
                return
            }
            products = p
            semaphore.signal()
            debugPrint("getProduct recieved response")
        }
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return products
    }
    
    class func getCategories()->ProductCategory?{
        let endpoint = MagentoApi.Endpoints.categories
        let url = endpoint.url
        let semaphore = DispatchSemaphore(value: 0)
        var categories: ProductCategory?
        guard url != nil else {
            debugPrint("invalid url")
            return nil
        }
        
        MagentoApi.taskForGETMagento(url: url!, responseType: ProductCategory.self) { (p, e) in
            guard e == nil else {
                debugPrint("error fetching data", e?.localizedDescription ?? "")
                return
            }
            categories = p
            semaphore.signal()
            debugPrint("getCategory recieved api response")
        }
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return categories
    }
    
    
    
    enum Endpoints {
        static let base = "https://dwdqzrgarxx36.cloudfront.net/rest/V1"
//        static let imageBase = "https://dwdqzrgarxx36.cloudfront.net/pub/media/catalog/product"
//        https://villa-images-sg.s3-ap-southeast-1.amazonaws.com/imageBySku/0056383
        static let imageSku = "https://villa-images-sg.s3-accelerate.amazonaws.com/imageBySku/"
        static let imageBase = "https://villa-images-sg.s3-accelerate.amazonaws.com"
        static let imageSlow = "https://villa-images-sg.s3-ap-southeast-1.amazonaws.com"
        static let alternativeImageBase = "https://dwdqzrgarxx36.cloudfront.net/pub/media/catalog/product"
        static let categoriesUrl = "https://dwdqzrgarxx36.cloudfront.net/rest/V1/categories"
    //    static let apiKeyParam = "?api_key=\(TMDBClient.apiKey)"
        
        case products(String)
        case image(String)
        case categories
        case alternativeImage(String)

        
            
        var stringValue: String {
                switch self {
                case .alternativeImage(let imageUrl): return Endpoints.alternativeImageBase + imageUrl
                case .products(let page): return Endpoints.base + "/products?searchCriteria[pageSize]=100&searchCriteria[currentPage]=\(page)"
                case .image(let imageUrl): return Endpoints.imageSku + imageUrl
                case .categories: return Endpoints.categoriesUrl
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
    
    
    
    /// download images ///
    class func getMagentoImage(imageUrlString:String, sku:String , completion : @escaping (UIImage?, String)->Void){
        let endpoint = MagentoApi.Endpoints.image(imageUrlString)
        let url = endpoint.url
        MagentoApi.downloadImage(url: url!) { (downloadedImage) in
            if let downloadedImage = downloadedImage {
                completion(downloadedImage, sku)
            } else {
                debugPrint("magento borderless images not found")
                
                // get alternative image
                let alternativeEndpoint =  MagentoApi.Endpoints.alternativeImage(imageUrlString)
                let alternativeUrl = alternativeEndpoint.url
                if let alternativeUrl = alternativeUrl {
                    debugPrint("calling to the url", alternativeUrl)
                    MagentoApi.downloadImage(url: alternativeUrl) { (downloadedImage) in
                        if let downloadedImage = downloadedImage {
                            completion(downloadedImage, sku)
                        }
                    }
                } else {
                    debugPrint("error parsing image url")
                }
            }
            completion(nil, sku)
        }
    }

    
    class func downloadImage(url:URL , completion : @escaping (UIImage?)->Void){
        
        let resource = ImageResource(downloadURL: url)
        
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                print("Image: \(value.image). Got from: \(value.cacheType)")
                completion(value.image as UIImage)
                
            case .failure(let error):
                print("Error: \(error)")
                completion(nil)
            }
        }
    }
    
    ///
    class func taskForGETMagento<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(CredentialsApi.magentoApiKey, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? String
                        if let json = json {
//                            let index = json.index(json.startIndex, offsetBy: 10)
                            debugPrint("json received")
                            debugPrint(json)
                        } else {
                            debugPrint("json received but slicing error")
                        }
                        completion(nil, error)

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

//struct MagentoApi_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}
