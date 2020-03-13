//
//  ContentView.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @Binding var showMenu: Bool
    @EnvironmentObject var productList:ProductList
    @EnvironmentObject var rootGeometry:RootGeometry
    
    @Binding var selectedItem:Int
    @Binding var presentProduct:Bool
    
    var body: some View {
        GeometryReader{ geometry in
            ProductsTable(selectedItem: self.$selectedItem, presentProduct: self.$presentProduct)
                .onAppear{
                    self.rootGeometry.geometry = geometry
            }
            .environmentObject(self.productList)
            .environmentObject(self.rootGeometry)

        }
    }
}





#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            MainView(showMenu: .constant(true), selectedItem: .constant(0), presentProduct: .constant(false))
            .environmentObject(
                ProductList(products: SampleProductList.products)
            )
            .environmentObject(RootGeometry(geometry: nil))

            
            
            MainView(showMenu: .constant(true), selectedItem: .constant(0), presentProduct: .constant(false))
            .environment(\.colorScheme, .dark)
            .environmentObject(
                ProductList(products: SampleProductList.products)
            )
            .environmentObject(
                RootGeometry(geometry: nil)
            )
            .environmentObject(RootGeometry(geometry: nil))

        }
    }
}
#endif
