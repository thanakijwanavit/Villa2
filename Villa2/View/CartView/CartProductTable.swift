//
//  CartProductTable.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct CartProductTable: View {
    @EnvironmentObject var productList:ProductList
    @EnvironmentObject var rootGeometry:RootGeometry


    var body: some View {
        VStack{
            ForEach(0..<productList.cart.count, id: \.self) {productID in
                CartProductTableCell(product: self.productList.cart[productID])
                    .environmentObject(self.rootGeometry)
                    .environmentObject(self.productList)


            }
        }
    }
}

struct CartProductTable_Previews: PreviewProvider {
    static var previews: some View {
        CartProductTable()
            .environmentObject(ProductList(products: SampleProductList.products))
            .environmentObject(RootGeometry(geometry: nil))


    }
}
