////
////  ContentView.swift
////  Villa2
////
////  Created by nic Wanavit on 3/13/20.
////  Copyright © 2020 tenxor. All rights reserved.
////
//
//import SwiftUI
//import KingfisherSwiftUI
//struct HomeViewController: View {
//    @Binding var showMenu: Bool
//    @EnvironmentObject var productList:ProductList
//    @Binding var selectedItem:Int
//    @Binding var presentProduct:Bool
//    
//    var body: some View {
//        VStack{
//            HomeView()
//        }
//    }
//}
//
//
//
//
//
//#if DEBUG
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group{
//            HomeViewController(showMenu: .constant(true), selectedItem: .constant(0), presentProduct: .constant(false))
//                .background(Color(.systemBackground))
//
//            
//            HomeViewController(showMenu: .constant(true), selectedItem: .constant(0), presentProduct: .constant(false))
//                .background(Color(.systemBackground))
//
//            .environment(\.colorScheme, .dark)
//        }
//        .environmentObject(
//            SampleProductList.productList
//        )
//        .environmentObject(
//            RootGeometry(geometry: nil)
//        )
//    }
//
//}
//#endif
