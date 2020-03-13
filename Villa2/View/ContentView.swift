//
//  ContentView.swift
//  swiftuiHE
//
//  Created by nic Wanavit on 3/10/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(\.window) var window: UIWindow?
    @EnvironmentObject var user: CurrentUser
    @EnvironmentObject var presentation: PresentationStatus
    @EnvironmentObject var productList:ProductList
    @EnvironmentObject var rootGeometry:RootGeometry
    
    @State var selectedItem:Int = 0
    //Display popups
    @State var showMenu = false
    @State var showProfile = false
    @State var presentProduct = false
    @State var showCart = false
    @State var showLogin = false


    
    var body: some View {
        

        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    
                    
                    
                    MainView(showMenu: self.$showMenu,selectedItem: self.$selectedItem,presentProduct: self.$presentProduct)
                        .environmentObject(self.user)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                        .disabled(self.showMenu ? true : false)
                    
                    if self.showMenu {
                        MenuView()
                            .environmentObject(self.presentation)
                            .environmentObject(self.user)
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                    
                    
                    
                    
                    
                }
                    .gesture(drag)
                
                // present profile page
                .sheet(isPresented: self.$presentation.profile){
                    ProfilePage()
                        .environmentObject(self.user)
                }
                
                // present product page
                .sheet(isPresented: self.$presentProduct) {
                    SingleProductView(productID: self.$selectedItem)
                        .environmentObject(self.rootGeometry)

                }
                
                //present login
                .sheet(isPresented: self.$showLogin) {
                    LoginView(showLogin:self.$showLogin)
                    .environmentObject(self.user)
            
                }
                
                //present cart
                .sheet(isPresented: self.$showCart) {
                    CartView()
                        .environmentObject(self.productList)
                        .environmentObject(self.rootGeometry)

                }
                
                // set title
                .navigationBarTitle("Villa", displayMode: .inline)
                // set items
                .navigationBarItems(leading: (
                    NavigationBarLeadingItems(showMenu: self.$showMenu, showLogin: self.$showLogin)
                        .environmentObject(self.user)
                        
                ),trailing: (
                    NavigationBarTrailingItems(showCart: self.$showCart)
                        .environmentObject(self.user)
                        .environmentObject(self.productList)


                    )
                )
            }
        }
    }
}





//
#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
            .environmentObject(CurrentUser(isLoggedIn: true, name: "stamp"))
            .environmentObject(
                ProductList(products: SampleProductList.products)
            )
            .environmentObject(RootGeometry(geometry: nil))
            .environmentObject(PresentationStatus())

            
            
            ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
            .environmentObject(CurrentUser(isLoggedIn: false, name: "stamp"))
            .environmentObject(
                ProductList(products: SampleProductList.products)
            )
            .environmentObject(RootGeometry(geometry: nil))
            .environmentObject(PresentationStatus())
            .environment(\.colorScheme, .dark)


        }
        

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
