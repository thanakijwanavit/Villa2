//
//  ProductsTable.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct ProductsTable: View {
    @EnvironmentObject var productList:ProductList
    @EnvironmentObject var rootGeometry:RootGeometry
    @Binding var selectedItem:Int
    @Binding var presentProduct:Bool
    var body: some View {
        List {
            Text("hello")
            ForEach(0 ..< productList.products.count ){ productID in
                ProductCell(product: self.productList.products[productID])
                    .environmentObject(self.rootGeometry)
                    .environmentObject(self.productList)
                    .onTapGesture {
                        self.selectedItem = productID
                        self.presentProduct = true
                }
            }
        }
        
    }
}

#if DEBUG
struct ProductsTable_Previews: PreviewProvider {
    static var previews: some View {
        ProductsTable(selectedItem: .constant(0), presentProduct: .constant(false))
        .environmentObject(
            ProductList(products: SampleProductList.products)
        )
        .environmentObject(RootGeometry(geometry: nil))

    }
}
#endif
