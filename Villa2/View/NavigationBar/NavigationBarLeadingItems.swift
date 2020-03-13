//
//  NavigationBarLeadingItems.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct NavigationBarLeadingItems: View {
    @EnvironmentObject var user:CurrentUser
    @Binding var showMenu:Bool
    @Binding var showLogin:Bool
    var body: some View {
        HStack{
            
            // Menu Button
            Button(action: {
                withAnimation {
                    self.showMenu.toggle()
                }
            }) {
                Image(systemName: "line.horizontal.3")
                    .imageScale(.large)
            }
            
            
            Button(action: {
                self.showLogin.toggle()
                }){
                    if self.user.isLoggedIn{
                        Text("hello \(self.user.name)")
                    } else {
                        Text("login")
                    }
            }
                .disabled(user.isLoggedIn)
            
        }
    }
}

struct NavigationBarLeadingItems_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarLeadingItems(showMenu:.constant(false), showLogin: .constant(false))
        .environmentObject(CurrentUser(isLoggedIn: true, name: "mock name"))
    }
}
