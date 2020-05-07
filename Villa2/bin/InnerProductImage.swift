////
////  InnerProductImage.swift
////  Villa2
////
////  Created by nic Wanavit on 3/14/20.
////  Copyright © 2020 tenxor. All rights reserved.
////
//
//import SwiftUI
//
//struct InnerProductImage: View {
//    var product:ProductRaw
//    var width:CGFloat
//    var body: some View {
//        Image(uiImage: self.product.image)
//        .resizable()
//        .renderingMode(.original)
//        .frame(width: self.width, height: self.width)
////        .foregroundColor(.purple)
//        .padding()
//    }
//}
//
//struct InnerProductImage_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            InnerProductImage(product: SampleProductList.products[1], width: 30)
//                .background(Color(.systemBackground))
//                .environment(\.colorScheme, .dark)
//                .previewLayout(.sizeThatFits)
//            InnerProductImage(product: SampleProductList.products[1], width: 30)
//                .background(Color(.systemBackground))
//                .environment(\.colorScheme, .light)
//                .previewLayout(.sizeThatFits)
//        }
//    }
//}
