//
//  SideMenuView.swift
//  swiftuiHE
//
//  Created by nic Wanavit on 3/10/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI
struct MenuView: View {
    @Environment(\.window) var window: UIWindow?
    @EnvironmentObject var user: CurrentUser
    @EnvironmentObject var presentation: PresentationStatus

    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
            
                NavigationLink(destination: ProfilePage().environmentObject(self.user)) {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Profile")
                            .foregroundColor(.gray)
                            .font(.headline)
                        Spacer()
                    }
                }
                .padding()
                
                NavigationLink(destination: DeliveryLocation(isDisplayed: .constant(true))) {
                    HStack {
                        Image(systemName: "map")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                        Text("Delivery Location")
                        .foregroundColor(.gray)
                        .font(.headline)
                        Spacer()
                    }
                }
                .padding()
                
                
                NavigationLink(destination: StoreFinder()) {
                    HStack {
                        Image("store")
                        .modifier(IconsModifier())
                        .foregroundColor(.gray)
                        .imageScale(.large)
                        Text("Store Finder")
                        .foregroundColor(.gray)
                        .font(.headline)
                        Spacer()
                    }
                }
                .padding()

            
                NavigationLink(destination: ProfilePage()) {
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Messages")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                }
                .padding()
                
                NavigationLink(destination: ProfilePage()) {
                    HStack {
                        Image(systemName: "gear")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Settings")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }
                }
                .padding()
                
                Spacer()
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
