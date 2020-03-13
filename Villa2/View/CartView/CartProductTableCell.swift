//
//  CartProductTableCell.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct CartProductTableCell: View {
    @EnvironmentObject var productList:ProductList
    @EnvironmentObject var rootGeometry:RootGeometry

    var product:ProductRaw
    
    var body: some View {
        HStack{
            ProductImage(product: product)
            .environmentObject(self.rootGeometry)
            Text(product.name)
            Text(self.product.description ?? "")
//            Text("hello world")
        }
    }
}

struct CartProductTableCell_Previews: PreviewProvider {
    static var previews: some View {
        CartProductTableCell(product: SampleProductList.products[1])
            .environmentObject(ProductList(products: SampleProductList.products))
            .environmentObject(RootGeometry(geometry: nil))


    }
}
