//
//  ProductCoreButton.swift
//  Villa2
//
//  Created by nic Wanavit on 3/28/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI
import CoreData

struct ProductCoreQuantityButton: View {
//    @EnvironmentObject var productList:ProductList
    
    var product: ProductCore
    @Binding var quantity: Int
    var width:CGFloat

    var body: some View {
        ZStack(alignment: .leading){
            HStack(alignment: .center) {
                
                // remove button
                Button(action: {
//                    Actions
                    if self.quantity > 0 {
                        self.quantity -= 1
                        debugPrint("reducting 1 product", "current quantity is \(self.quantity)")
                    } else {
                        debugPrint("cant reduct, prodcut q is 0")
                    }
                }) {
                    Image(systemName: "minus")
                    .frame(width: width/4, height: width/4)
                }

                
                // quantity text field
                Text(self.quantity.string)
                    .frame(width: width/2.5, height: width/3)
                
                // add button
                Button(action: {
    //                    Actions
                    debugPrint("adding 1 product", "current quantity is \(self.quantity)")
                    self.quantity += 1
                    }) {
                        Image(systemName: "plus")
                        .frame(width: width/4, height: width/4)
                    }
                
            }
            .buttonStyle(BorderlessButtonStyle())
            .frame(width: width, height: 33, alignment: .center)
            .padding(.horizontal)
            .overlay(Capsule().stroke(
                Color.blue.opacity(0.5),lineWidth: 5)
                )
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

#if DEBUG
struct ProductCoreButton_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let productCore = ProductCore(context: moc)
        productCore.name = "testProduct"
        productCore.numberInCart = 2
        productCore.productDescription = "sdfaffa"
        productCore.imageData = UIImage(systemName: "basket")?.pngData()!
        return Group {
            ProductCoreQuantityButton(product: productCore, quantity: .constant(2), width: 50)

        }
    }
}
#endif
