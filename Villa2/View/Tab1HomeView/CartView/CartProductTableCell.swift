//
//  CartProductTableCell.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct CartProductTableCell: View {
    @State var disableAnimation:Bool
    @ObservedObject var productCoreWrapper:ProductCoreWrapper
    @Environment(\.managedObjectContext) var moc

    var product:ProductCore
    
    init(disableAnimation:Bool ,product:ProductCore){
        //set up products
        var productCoreWrapper_ = ProductCoreWrapper(productCore: product)
        self.productCoreWrapper = productCoreWrapper_
        self.product = productCoreWrapper_.productCore
        //set up others
        self._disableAnimation = State(initialValue: disableAnimation)
    }
    
    var body: some View {
        
        var quantity:Binding<Int> = Binding<Int>(get: {
            return self.product.quantityInCart
        },set: {
            self.product.quantityInCart = $0
            try? self.moc.save()
        })
        
        return VStack{
            HStack{
                //image and quantity selector
                VStack(alignment: .leading) {
                    ProductCoreImage(disableImageAnimation: self.$disableAnimation, width: 100, productCore: self.product)
                        .padding()
                    
                    CartQuantityButton(quantity: quantity)
                        .padding(.leading)
                        .padding(.bottom)

                }
                       
                
                //description and price
                VStack(alignment: .leading){
                    Text(product.name ?? "")
                        .lineLimit(1)
                        .padding(.trailing)
                        .padding(.bottom)

                    Text("\(self.product.productDescription ?? "" ) \(String(repeating: " ", count: 100))")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.body)
//                        .fontWeight(.light)
//                        .multilineTextAlignment(.leading)
                        .lineLimit(4)
                        .padding(.trailing)
                    Text("\(self.product.priceDescription)")
                        .padding(.trailing)
                        .padding(.top)
                        .lineLimit(1)
                   }
               }
                   .font(.system(size: 20, weight: .semibold, design: .default))
            
            
        }
    }
}

struct CartProductTableCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CartProductTableCell(disableAnimation: false, product: SampleProductCore.productCore)
            .environmentObject(ProductList(products: SampleProductList.products))
            .environmentObject(RootGeometry(geometry: nil))
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .dark)
            .previewLayout(.sizeThatFits)
            
            CartProductTableCell(disableAnimation: false, product: SampleProductCore.productCore)
            .environmentObject(ProductList(products: SampleProductList.products))
            .environmentObject(RootGeometry(geometry: nil))
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .light)
            .previewLayout(.sizeThatFits)
        }
        .environment(\.managedObjectContext, SampleProductCore.context)

        


    }
}

