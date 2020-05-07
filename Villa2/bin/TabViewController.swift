////
////  TabView.swift
////  Villa2
////
////  Created by nic Wanavit on 3/14/20.
////  Copyright © 2020 tenxor. All rights reserved.
////
//
//import SwiftUI
//
//
//
//
//
//
//
//struct TabViewController: View {
//    @Environment(\.colorScheme) var colorScheme: ColorScheme
//    @Environment(\.window) var window: UIWindow?
//    @EnvironmentObject var user: CurrentUser
//    @EnvironmentObject var presentation: PresentationStatus
//    @EnvironmentObject var productList:ProductList
//    @EnvironmentObject var rootGeometry:RootGeometry
//
//    @EnvironmentObject var tabStatus: TabStatus
//
//    var mocklist:[String] = ["hey", "ho", "hello"]
//
//    var body: some View {
//        TabView (selection: self.$tabStatus.tabChoice){
////            Tab1ViewNavigationController()
////                .environment(\.window, window)
////                .environmentObject(productList)
////                .environmentObject(rootGeometry)
////                .environmentObject(user)
////                .environmentObject(presentation)
////                .environmentObject(tabStatus)
//
//            Text("mock tab 1")
//                .tabItem {
//                    Image(systemName: "tray.2.fill")
//                    Text("All")
//                    }.tag(TabChoice.tab1)
//
////            Tab1MainView()
////                .environmentObject(productList)
////                .environmentObject(rootGeometry)
////                .tabItem {
////                    Image(systemName: "2.circle")
////                    Text("Second")
////                    }.tag(TabChoice.tab2)
//
//
//            VStack{
//                Text("hello")
//                Text("hello2")
//                List {
//                    ForEach(1..<100, id: \.self) { productID in
//                        Text("hello \(productID)")
//                        }
//                    }
//                }
//                .tabItem {
//                    Image(systemName: "2.circle")
//                    Text("Second")
//                    }.tag(TabChoice.tab2)
//
//
//
//            Text("Second View")
//                .tabItem {
//                    Image(systemName: "3.circle")
//                    Text("Third")
//                    }.tag(TabChoice.tab3)
//
//            CartView()
//                .environmentObject(self.productList)
//                .environmentObject(self.rootGeometry)
//                .tabItem {
//                    if productList.cart.count == 0 {
//                        Image(systemName: "cart")
//                        Text("cart")
//                    } else {
//                        Image(systemName: "cart.fill")
//                        Text("cart")
//                    }
//                    }.tag(TabChoice.cart)
//        }
//    }
//}
//
//struct TabViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            TabViewController()
//            .environmentObject(TabStatus())
//            .environmentObject(ProductList(products: SampleProductList.products))
//            .environmentObject(RootGeometry(geometry: nil))
//            .environmentObject(CurrentUser())
//            .environmentObject(PresentationStatus())
//
//
//            TabViewController()
//            .environmentObject(TabStatus())
//            .environmentObject(ProductList(products: SampleProductList.products))
//            .environmentObject(RootGeometry(geometry: nil))
//            .environmentObject(CurrentUser())
//            .environmentObject(PresentationStatus())
//            .environment(\.colorScheme, .dark)
//        }
//    }
//}
