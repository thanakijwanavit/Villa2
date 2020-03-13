//
//  CartView.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var productList:ProductList
    @EnvironmentObject var rootGeometry:RootGeometry


    var body: some View {
        ZStack{
            Color.red
            
            
            CartProductTable()
            .environmentObject(productList)
            .environmentObject(self.rootGeometry)
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(ProductList(products: SampleProductList.products))
            .environmentObject(RootGeometry(geometry: nil))
    }
}
