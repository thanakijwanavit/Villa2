//
//  ContentView.swift
//  tabBarControllerDemo
//
//  Created by nic Wanavit on 3/14/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI
import CoreData


struct TabBarControllerView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
//    @Environment(\.window) var window: UIWindow?
    //Getting number of products
    @EnvironmentObject var user:CurrentUser
    var numberOfProducts:Int{
        var totalProducts = 0
        for product in productCores{
            totalProducts += product.quantityInCart
        }
        return totalProducts
    }
    var fetchRequest: FetchRequest<ProductCore>
    var productCores: FetchedResults<ProductCore>{
        fetchRequest.wrappedValue
    }
    
    init(){
        //get number of products in cart form coredata
        let request: NSFetchRequest<ProductCore> = ProductCore.fetchRequest()
        request.fetchLimit = 100
        let predicate = NSPredicate(format: "isInCart == TRUE")
        request.predicate = predicate
        request.sortDescriptors = []
        self.fetchRequest = FetchRequest<ProductCore>(fetchRequest: request)
    }
    
    
    
    var body: some View {
        
        return ZStack {
            UITabBarWrapper([
                
                TabBarElement(tabBarElementItem: .init(title: "First", image: UIImage(systemName: "house.fill")!)) {
                    Tab1View()

                },
//                TabBarElement(tabBarElementItem: .init(title: "Second", image: UIImage(systemName: "rectangle.3.offgrid")!)) {
//                    Tab2View()
//                },
//                TabBarElement(tabBarElementItem: .init(title: "Chat", image: UIImage(systemName: "message")!)) {
//                    Tab3View()
//                },
                
                TabBarElement(tabBarElementItem: .init(title: "Wallet", image: UIImage(systemName: "creditcard.fill")!, badge: 5.string)) {
                    WalletMainView()
                },
                
                TabBarElement(tabBarElementItem: .init(title: "Settings", image: UIImage(systemName: "gear")!)) {
                    MenuView()
                    .environmentObject(self.user)
                },
            ])
            .edgesIgnoringSafeArea(.all)
        }
    }
}



struct TabBarControllerView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            
            TabBarControllerView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
            
            TabBarControllerView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .environment(\.colorScheme, .dark)
        }
        .environmentObject(SampleProductList.productList)
        .environmentObject(RootGeometry(geometry: nil))
        .environmentObject(CurrentUser(isLoggedIn: false, name: "stamp"))
        .environmentObject(ProductList(products: SampleProductList.products))
        .environmentObject(PresentationStatus())
        .environment(\.colorScheme, .dark)
        .environmentObject(TabStatus())
    }
}
