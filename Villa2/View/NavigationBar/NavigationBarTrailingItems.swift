//
//  NavigationBarTrailingItems.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct NavigationBarTrailingItems: View {
    @EnvironmentObject var user:CurrentUser
    @EnvironmentObject var productList:ProductList
    @Binding var showCart:Bool



    var body: some View {
        Button(action: {
            self.showCart.toggle()
            }){
                if self.productList.cart.count == 0 {
                    Image(systemName: "cart")

                } else {
                    Image(systemName: "cart.fill")

                }
            }
    }
}

struct NavigationBarTrailingItems_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarTrailingItems(showCart: .constant(false))
            .environmentObject(SampleCurrentUser.user)
            .environmentObject(ProductList(products: SampleProductList.products))
    }
}
