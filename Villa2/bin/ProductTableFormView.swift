////
////  ProductTableFormView.swift
////  Villa2
////
////  Created by nic Wanavit on 3/21/20.
////  Copyright © 2020 tenxor. All rights reserved.
////
//
//import SwiftUI
//
//struct ProductTableFormView: View {
//    @EnvironmentObject var productList:ProductList
//    @EnvironmentObject var rootGeometry:RootGeometry
////    @Binding var selectedItem:Int
////    @Binding var presentProduct:Bool
//    var body: some View {
//        GeometryReader { geometry in
//        ScrollView{
////        Form{
////            Section{
////                ScrollView{
//            ForEach(self.productList.products.prefix(through: 4), id:\.self){ product in
//                        ProductCell(product: product)
////                    }
////                }
////                
////            }
//        }
//        }
//        }
//    }
//}
//
//struct ProductTableFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ProductTableFormView()
//                .background(Color(.systemBackground))
//            
//            ProductTableFormView()
//                .background(Color(.systemBackground))
//            
//            .environment(\.colorScheme, .dark)
//        }
//        .previewDevice("iPhone X")
//        .environmentObject(SampleProductList.productList)
//        .environmentObject(RootGeometry(geometry: nil))
//    }
//}
