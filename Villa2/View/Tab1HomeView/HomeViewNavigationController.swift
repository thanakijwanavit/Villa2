//
//  ContentView.swift
//  swiftuiHE
//
//  Created by nic Wanavit on 3/10/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct HomeViewNavigationController: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(\.window) var window: UIWindow?
    @EnvironmentObject var user: CurrentUser
    @EnvironmentObject var presentation: PresentationStatus
    @EnvironmentObject var productList:ProductList
    @EnvironmentObject var rootGeometry:RootGeometry
    @EnvironmentObject var tabStatus:TabStatus
    @EnvironmentObject var showProductModal:ShowProductModal //= ShowProductModal()

    
    
    //Display popups
    @State var showMenu = false
    @State var showProfile = false
    @State var presentProduct = false
    @State var showCart = false
    @State var showLogin = false
    @State var showLocationSelector = true


    
    var body: some View {
        

//        let drag = DragGesture()
//            .onEnded {
//                if $0.translation.width < -100 {
//                    withAnimation {
//                        self.showMenu = false
//                    }
//                }
//            }
        
        return NavigationView {
            GeometryReader { g in
                ZStack(alignment: .leading) {
                    
                    self.mainHomeView(g: g)
                    
                }
                
                
                
                .onAppear(perform: {
                    debugPrint("location selector is \(self.showLocationSelector)")
                })
                
                    
                //navigationBar
                
                // set title
                .navigationBarTitle("Villa Market", displayMode: .automatic)
                // set items
                .navigationBarItems(leading: (
                    // leading bar items
                    HomeViewNavigationBarLeadingItems(showMenu: self.$showMenu, showLogin: self.$showLogin)
                        
                ),trailing: (
                    // trailing bar item
                    HomeViewNavigationBarTrailingItems()

                    )
                )
                
                //present login
                
            }
        }.sheet(isPresented: self.$showLocationSelector) {
                            DeliveryLocation(isDisplayed: self.$showLocationSelector)
                            
        //                    LoginView(showLogin:self.$showLogin)
                    
                        }
    }
    func mainHomeView(g: GeometryProxy)-> some View {
//        HomeViewController(showMenu: self.$showMenu,selectedItem: .constant(0),presentProduct: self.$presentProduct)
//        .frame(width: g.size.width, height: g.size.height)
//        .offset(x: self.showMenu ? g.size.width/2 : 0)
//        .disabled(self.showMenu ? true : false)
        HomeView()
    }
}





//
#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeViewNavigationController()

            HomeViewNavigationController()
            .environment(\.colorScheme, .dark)
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
        .environmentObject(CurrentUser(isLoggedIn: false, name: "stamp"))
        .environmentObject(SampleProductList.productList)
        .environmentObject(RootGeometry(geometry: nil))
        .environmentObject(PresentationStatus())
        .environmentObject(TabStatus())
        

    }
}
#endif

struct Action:Hashable {
    let name: String
    let pageName: String
    let image: Image
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
}
