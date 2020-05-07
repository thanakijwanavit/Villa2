//
//  TabsView.swift
//  tabBarControllerDemo
//
//  Created by nic Wanavit on 3/14/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI


struct Tab1View: View {

    var body: some View {
        HomeViewNavigationController()
    }
}
struct Tab2View: View {
    var body: some View {
        SearchViewNavigationController()
    }
}
struct Tab3View: View {
    var body: some View {
        Text("chat View")
    }
}
struct Tab4View: View {

    var body: some View {
//        CartView()
        Text("Tab4")
    }
}

#if DEBUG

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            Tab1View()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))

            
            
            Tab1View()
                .environment(\.colorScheme, .dark)
            
            Tab2View()
            Tab3View()
            Tab4View()
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
        .environmentObject(CurrentUser(isLoggedIn: false, name: "stamp"))
        .environmentObject(ProductList(products: SampleProductList.products))
        .environmentObject(RootGeometry(geometry: nil))
        .environmentObject(PresentationStatus())
        .environmentObject(TabStatus())

    }
}
#endif
