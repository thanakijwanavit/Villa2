//
//  SceneDelegate.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        // create product cat list
        let productCat:ProductCategoryList = ProductCategoryList(productCategory: SampleCategory.category)
        
        let catLinear = S3Api.getCatLinear()
        
        
        if let fetchedCatProducts = fetchCatFromCoreData(context: context){
            if let decodedProductCat = fetchedCatProducts.decodedCategoryList{
                // use the fetched data to update product cat
                productCat.products  = decodedProductCat
            } else {
                debugPrint("decoding product from core data failed")
            }
        } else {
            debugPrint("products not in core data")
        }
        
        
        
        
        
        DispatchQueue.global(qos: .background).async {
            if let downloadedCategories = MagentoApi.getCategories() {
                DispatchQueue.main.async {
                    productCat.products = downloadedCategories
                    //save to core data
                    if let fetchedCatProducts = fetchCatFromCoreData(context: context){
                        fetchedCatProducts.decodedCategoryList = downloadedCategories
//                        try? context.save()
                        CoreDataFunctions.saveContext()
                    } else {
                        debugPrint("Cat product empty, creating a new one")
                        let newCat = Categories(context: context)
                        newCat.decodedCategoryList = downloadedCategories
//                        try? context.save()
                        CoreDataFunctions.saveContext()

                    }
                }
                debugPrint("categories downloaded decoded successfully")
            }
        }
        
        
        
        
        
        // create product list
        
        var productRawList:ProductList = SampleProductList.productList
        
        //update core data
        appDelegate.persistentContainer.performBackgroundTask { (backgroundContext) in
            debugPrint("updating product cores")
            let products = S3Api.getProductCores(context: backgroundContext)
            if let products = products {
                debugPrint("product update succesfully ",products.first?.description ?? "product description is blank")
                
            } else {
                debugPrint("products are not updated")
            }
        }
        
        
        
        
        let contentView = TabBarControllerView()
            .environment(\.window, window)
            .environment(\.managedObjectContext, context)
            .environmentObject(productRawList)
            .environmentObject(RootGeometry(geometry: nil))
            .environmentObject(CurrentUser())
            .environmentObject(PresentationStatus())
            .environmentObject(TabStatus())
            .environmentObject(productCat)
            .environmentObject(ShowProductModal())


        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }



    func sceneDidEnterBackground(_ scene: UIScene) {

        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}




struct SceneDelegate_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
