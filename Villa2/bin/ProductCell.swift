//
//  ProductCell.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

//import SwiftUI
//
//struct ProductCell: View {
//    @EnvironmentObject var rootGeometry:RootGeometry
//    @EnvironmentObject var productList:ProductList
//    @State var product:ProductRaw
//
//    
//    var body: some View {
//        
//        var quantity = Binding<Int>(get: {
//            return SampleProductList.productList.getQuantityInCart(sku: self.product.sku)
//            
//        },
//            set: {
//                self.productList.setQuantityInCart(sku: self.product.sku, quantity: $0)
//                debugPrint("quantity in cart is set to:", $0)
//                debugPrint("test getting product quantity:", self.productList.getQuantityInCart(sku: self.product.sku))
//
//        })
//        
//        
//        return HStack(alignment: .top){
//            
//            VStack(alignment: .center){
//                // product image
//                Button(action: {
//                }){
//                    ProductImage(product: product)
//                }
//                .buttonStyle(BorderlessButtonStyle())
//                
//                Text(product.priceDescription)
//                
//                Text(product.name)
//                
//                Button("Add To Cart"){
//                    
//                }
//            }
//
//            // product description and button
////            ProductDescription(product: $product, quantity: quantity)
////                .environmentObject(self.rootGeometry)
////                .environmentObject(self.productList)
//
//        }
//
//    }
//    
//    private func imageWidth()->CGFloat{
//        return (self.rootGeometry.geometry?.size.width ?? 300) / 3
//    }
//}
//
//
//
//
//
//
//
//#if DEBUG
//struct ProductCell_Previews: PreviewProvider {
//    static var previews: some View {
//        Group{
//            ProductCell(product: SampleProductList.products[0])
//                .background(Color(.systemBackground))
//                .environment(\.colorScheme, .dark)
//                .previewLayout(.sizeThatFits)
//            
//            ProductCell(product: SampleProductList.products[1])
//            .previewLayout(.sizeThatFits)
//            
//            ProductCell(product: SampleProductList.products[0])
//                .previewLayout(.sizeThatFits)
//
//        }
//        .environmentObject(SampleProductList.productList)
//        .environmentObject(RootGeometry(geometry: nil))
//        .previewLayout(.sizeThatFits)
//    }
//}
//
//#endif
