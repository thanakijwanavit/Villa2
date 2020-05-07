//
//  ProductCoreQuantityButton.swift
//  Villa2
//
//  Created by nic Wanavit on 4/3/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI
struct CartQuantityButton: View {
//    @EnvironmentObject var productList:ProductList
    
//    var product: ProductCore
    @Environment(\.managedObjectContext) var moc
    @Binding var quantity: Int

    var body: some View {
        
        
        return ZStack(alignment: .leading){
            Capsule()
                .frame(width: 120, height: 40, alignment: .center)
                .foregroundColor(Color(UIColor.systemGray6))
            
            HStack(alignment: .center) {
                
                // add button
                ProductCoreModifierButton(quantity: $quantity, productButtonType: .remove)

                
                // quantity text field
                ProductQuantityTextField(quantity: $quantity)
                
                // remove button
                ProductCoreModifierButton(quantity: $quantity, productButtonType: .add)
                
            }
            .frame(width: 120, height: 40, alignment: .center)
                .overlay(Capsule().stroke(
                    Color.blue.opacity(0.2),lineWidth: 5)
                    )
                .padding(.trailing)
        }
        
    }
    
    private var numberFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.allowsFloats = false
        nf.maximumIntegerDigits = 2
        nf.minimumIntegerDigits = 1
        nf.minimum = 0
        return nf
    }
    
}

enum ProductButtonType: String{
    case add = "plus"
    case remove = "minus"
}

struct ProductQuantityTextField: View{
    @Binding var quantity:Int
    
    var body: some View {
//        TextField("quantity", value: $quantity, formatter: self.numberFormatter)
//        .keyboardType(.numberPad)
//        .multilineTextAlignment(.center)
        Text("\(quantity)")
            .font(.body)
//        .frame(width: 6, height: 10)
    }
    private var numberFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.allowsFloats = false
        nf.maximumIntegerDigits = 2
        nf.minimumIntegerDigits = 1
        nf.minimum = 0
        return nf
    }
}

struct ProductCoreModifierButton: View{
    @Binding var quantity:Int
//    @Binding var product:ProductRaw
    let productButtonType:ProductButtonType
    var body: some View {
        Button(action: {
            switch self.productButtonType{
            case .add:
                self.quantity += 1
                debugPrint("added, quantity is \(self.quantity)")
            case .remove:
                if self.quantity > 0 {
                    self.quantity -= 1
                    debugPrint("removed, quantity is \(self.quantity)")
                }
            }
        }){
            Image(systemName: self.productButtonType.rawValue)
        }
        .padding(12)
        .buttonStyle(BorderlessButtonStyle())
    }
}

struct ProductCoreQuantityButton_Previews: PreviewProvider {
    static var previews: some View {
        CartQuantityButton(quantity: .constant(1))
        .environment(\.managedObjectContext, SampleProductCore.context)

    }
}
