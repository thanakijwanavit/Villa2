////
////  ProductDescription.swift
////  Villa2
////
////  Created by nic Wanavit on 3/13/20.
////  Copyright © 2020 tenxor. All rights reserved.
////
//
//import SwiftUI
//
//struct ProductDescription: View {
//    @EnvironmentObject var rootGeometry:RootGeometry
//    @EnvironmentObject var productList:ProductList
//    
//    @Binding var product: ProductRaw
//    @Binding var quantity: Int
//    
//    var body: some View {
//        
//        VStack(alignment:.leading){
//            Text(product.name)
//                .font(.headline)
//                .padding(.leading)
//                .padding(.trailing)
//                .animation(nil)
//            
//            
//            Text("\(product.description ?? "") " + String(repeating: " ", count: 100))
//                .font(.body)
//                .lineLimit(5)
//                .padding(.leading)
//                .padding(.trailing)
//                .animation(nil)
//            
//            //// the control buttons
////            HStack{
////
////                // all button suite
////                ProductQuantityButton(product: $product, quantity: $quantity)
////                .environmentObject(productList)
////                    .padding()
////
////
////                //add item to favourite
////                Button(action: {
////                    self.product.isFavourite.toggle()
////                }){
////                    Image(systemName: product.isFavourite ? "star":"star.fill")
////                }
////                .padding()
////                .buttonStyle(BorderlessButtonStyle())
////                // remove item from cart
//////                Button(action: {
//////                    self.product.quantityInCart = 0
//////                }){
//////                    Image(systemName: "trash")
//////                }
//////                .padding()
//////                .buttonStyle(BorderlessButtonStyle())
////
////            }
//            
//            
//        }
////        .frame(maxHeight: self.maxHeight())
//    }
//    
//    private func maxHeight()->CGFloat{
//        return (self.rootGeometry.geometry?.size.width ?? 300) / 3
//    }
//}
//
//#if DEBUG
//
//struct ProductDescription_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ProductDescription(product: .constant(SampleProductList.products[0]), quantity: .constant(5))
//                
//                .background(Color(.systemBackground))
//                .environment(\.colorScheme, .dark)
//                .previewLayout(.sizeThatFits)
//            
//            ProductDescription(product: .constant(SampleProductList.products[0]), quantity: .constant(5))
//                .background(Color(.systemBackground))
//                .environment(\.colorScheme, .light)
//                .previewLayout(.sizeThatFits)
//        }
//            .environmentObject(RootGeometry(geometry: nil))
//            .environmentObject(SampleProductList.productList)
//
//    }
//}
//#endif
