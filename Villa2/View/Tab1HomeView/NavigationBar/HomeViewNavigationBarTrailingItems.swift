//
//  NavigationBarTrailingItems.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct HomeViewNavigationBarTrailingItems: View {
    @EnvironmentObject var user:CurrentUser
    @EnvironmentObject var productList:ProductList
    @EnvironmentObject var tabStatus:TabStatus
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        HStack{
            
            if user.isLoggedIn {
                Button(action: {
                    self.user.isLoggedIn.toggle()
                }){
                    Text("Logout")
                    }
            }
            
            
            NavigationLink(destination:
                CartView()
                    .environment(\.managedObjectContext, moc)
            ) {
                GoToCartButton(isCheckout: .constant(false), showModal: .constant(false))
                    .environment(\.managedObjectContext, moc)
            }
        }
    }
}

struct NavigationBarTrailingItems_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeViewNavigationBarTrailingItems()
            .environmentObject(SampleCurrentUser.user)
            .environmentObject(ProductList(products: SampleProductList.products))
            .environmentObject(TabStatus())
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .light)
            .previewLayout(.sizeThatFits)
            
            HomeViewNavigationBarTrailingItems()
            .environmentObject(SampleCurrentUser.user)
            .environmentObject(ProductList(products: SampleProductList.products))
            .environmentObject(TabStatus())
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .dark)
            .previewLayout(.sizeThatFits)
        }
        


    }
}
