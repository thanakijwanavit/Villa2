////
////  ProductQuantityButton.swift
////  Villa2
////
////  Created by nic Wanavit on 3/14/20.
////  Copyright © 2020 tenxor. All rights reserved.
////
//
//import SwiftUI
//
//struct ProductQuantityButton: View {
//    @EnvironmentObject var productList:ProductList
//    
//    var product: ProductRaw
//    @Binding var quantity: Int
//
//    var body: some View {
//        ZStack(alignment: .leading){
//            Capsule()
//                .frame(width: 120, height: 40, alignment: .center)
//                .foregroundColor(Color(UIColor.systemGray6))
//            
//            HStack(alignment: .center) {
//                
//                // add button
//                ProductModifierButton(quantity: $quantity, productButtonType: .remove)
//                .environmentObject(productList)
//
//                
//                // quantity text field
//                TextField("quantity", value: $quantity, formatter: self.numberFormatter)
//                    .keyboardType(.numberPad)
//                    .multilineTextAlignment(.center)
//                
//                // remove button
//                ProductModifierButton(quantity: $quantity, productButtonType: .add)
//                .environmentObject(productList)
//                
//            }
//            .frame(width: 120, height: 40, alignment: .center)
//                .overlay(Capsule().stroke(
//                    Color.blue.opacity(0.2),lineWidth: 5)
//                    )
//                .padding(.trailing)
//        }
//        
//    }
//    
//    private var numberFormatter: NumberFormatter {
//        let nf = NumberFormatter()
//        nf.allowsFloats = false
//        nf.maximumIntegerDigits = 2
//        nf.minimumIntegerDigits = 1
//        nf.minimum = 0
//        return nf
//    }
//    
//}
//
////enum ProductButtonType: String{
////    case add = "plus"
////    case remove = "minus"
////}
//
//struct ProductModifierButton: View{
//    @Binding var quantity:Int
////    @Binding var product:ProductRaw
//    let productButtonType:ProductButtonType
//    @EnvironmentObject var productList:ProductList
//
//    var body: some View {
//        Button(action: {
//            switch self.productButtonType{
//            case .add:
//                self.quantity += 1
//            case .remove:
//                if self.quantity > 0 {
//                    self.quantity -= 1
//                }
//            }
//        }){
//            Image(systemName: self.productButtonType.rawValue)
//        }
//        .padding(12)
//        .buttonStyle(BorderlessButtonStyle())
//    }
//}
//
//#if DEBUG
//
//struct ProductQuantityButton_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        Group{
//            
//            ProductQuantityButton(product: SampleProductList.products[2], quantity: .constant(5))
//            .background(Color(.systemBackground))
//                .environment(\.colorScheme, .light)
//                .previewLayout(.sizeThatFits)
//            .environmentObject(SampleProductList.productList)
//
//            
//            ProductQuantityButton(product: SampleProductList.products[2], quantity: .constant(5))
//            .background(Color(.systemBackground))
//                .environment(\.colorScheme, .dark)
//                .previewLayout(.sizeThatFits)
//            .environmentObject(SampleProductList.productList)
//
//            
//            ProductCell(product: SampleProductList.products[0])
//            .environmentObject(RootGeometry(geometry: nil))
//            .environmentObject(SampleProductList.productList)
//            .background(Color(.systemBackground))
//                .environment(\.colorScheme, .dark)
//                .previewLayout(.sizeThatFits)
//            .environmentObject(SampleProductList.productList)
//
//
//            
//            ProductModifierButton(quantity: .constant(5), productButtonType: .add)
//            .background(Color(.systemBackground))
//                .environment(\.colorScheme, .dark)
//                .previewLayout(.sizeThatFits)
//            .environmentObject(SampleProductList.productList)
//
//        }
//        
//    }
//}
//#endif
