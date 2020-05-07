//
//  CartProductTable.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct CartProductTable: View {
//    @EnvironmentObject var rootGeometry:RootGeometry
    var productCores:FetchedResults<ProductCore>
    var numberOfProducts:Int{
        var totalProducts = 0
        for product in productCores{
            totalProducts += product.quantityInCart
        }
        return totalProducts
    }
    @State var disableAnimation = false
    var cartTotal:Float {
        var total = 0
        for product in self.productCores{
            total += Int(product.price) * product.quantityInCart
        }
        return Float(total)
    }

    

    var body: some View {
        VStack{
            CartViewHeaderCell(cartTotal: self.cartTotal, numberOfProducts: self.numberOfProducts)
            ScrollView {
            ForEach(productCores, id: \.self) {productCore in
                CartProductTableCell(disableAnimation: self.disableAnimation, product: productCore)
                }
            }
        }
    }
}

//
//struct CartProductTable_Previews: PreviewProvider {
//    let fetchedRequestR
//        CartProductTable(productCores: SampleProductCore.context.fetch(<#T##request: NSFetchRequest<NSFetchRequestResult>##NSFetchRequest<NSFetchRequestResult>#>))
//        .environment(\.managedObjectContext, SampleProductCore.context)
//
////        .
//    }
//}
