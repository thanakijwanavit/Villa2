////
////  ProductImage.swift
////  Villa2
////
////  Created by nic Wanavit on 3/13/20.
////  Copyright © 2020 tenxor. All rights reserved.
////
//
//import SwiftUI
//
//struct ProductImage: View {
//    @EnvironmentObject var rootGeometry:RootGeometry
//    @State var overrideWidth:Float?
//    @State var imageAnimation:Double = -20
//    var product: ProductRaw
//    var body: some View {
//            ZStack(alignment: .center){
////                ProductImageBackground(width: imageWidth())
//                    
//                InnerProductImage(product: product, width: imageWidth())
//                .opacity(1)
//                
//            }
//            .rotation3DEffect(.degrees(self.imageAnimation), axis: (x: 0, y: 1, z: 0))
//            .onAppear{
//                withAnimation(.interpolatingSpring(stiffness: 2, damping: 1)){
//                    self.imageAnimation = 180
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                        withAnimation(.interpolatingSpring(stiffness: 2, damping: 1)){
//                        self.imageAnimation = 1
//                        }
//                    }
//                }
//            }
//        }
//    
//    private func imageWidth()->CGFloat{
//        if let overrideWidth = self.overrideWidth {
//            return CGFloat(overrideWidth)
//        }
//        return 300 / 3
//    }
//}
//
//struct ProductImage_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ProductImage(product: SampleProductList.products[0])
//            .environmentObject(RootGeometry(geometry: nil))
//            .background(Color(.systemBackground))
//            .environment(\.colorScheme, .light)
//            .previewLayout(.sizeThatFits)
//            
//            ProductImage(product: SampleProductList.products[0])
//            .environmentObject(RootGeometry(geometry: nil))
//            .background(Color(.systemBackground))
//            .environment(\.colorScheme, .dark)
//            .previewLayout(.sizeThatFits)
//        }
//        
//    }
//}
