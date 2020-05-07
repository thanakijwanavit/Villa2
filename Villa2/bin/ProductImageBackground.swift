////
////  ProductImageBackground.swift
////  Villa2
////
////  Created by nic Wanavit on 3/14/20.
////  Copyright © 2020 tenxor. All rights reserved.
////
//
//import SwiftUI
//
//struct ProductImageBackground: View {
//    var width:CGFloat
//    var body: some View {
//        Color(UIColor.systemBackground)
//            .opacity(0.0)
//            .frame(width: self.width+5 , height: self.width+5 )
//            .clipShape(
//                RoundedRectangle(cornerRadius: width/7)
//        )
////                .padding(10)
//            .overlay(
//                RoundedRectangle(cornerRadius: width/7)
//                    .stroke(Color.green.opacity(0.0), lineWidth: 5)
//            )
////            .shadow(radius: 1)
//    }
//}
//
//struct ProductImageBackground_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ProductImageBackground(width: 50)
//            .background(Color(.systemBackground))
//            .environment(\.colorScheme, .dark)
//            .previewLayout(.sizeThatFits)
//            
//            
//            ProductImageBackground(width: 50)
//            .background(Color(.systemBackground))
//            .environment(\.colorScheme, .light)
//            .previewLayout(.sizeThatFits)
//        }
//        
//    }
//}
