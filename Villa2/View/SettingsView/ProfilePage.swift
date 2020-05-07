//
//  ProfilePage.swift
//  swiftuiHE
//
//  Created by nic Wanavit on 3/10/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct ProfilePage: View {
    @EnvironmentObject var user:CurrentUser
    
    
    var body: some View {
        VStack{
            ProfileImage()
            .environmentObject(self.user)
            
            HStack{
                Text("Name:")
                    .padding()
                Spacer()
                Text(user.name ?? "")
                    .padding()
                Spacer()
            }
            .font(.largeTitle)
            
            HStack{
                Text("Age:")
                    .padding()
                Spacer()
                Text("\(user.age ?? 0)")
                    .padding()
                Spacer()
            }
            .font(.largeTitle)
        }
    }
}


struct ProfileImage: View{
    
    @EnvironmentObject var user:CurrentUser
    
    var body: some View {
        GeometryReader { geometry in
            Image("imagemock")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width - 80, height: geometry.size.width, alignment: .center)
                .padding(.all, 20)
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(Color.gray, lineWidth: 15))
        }
    }
}



#if DEBUG

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfilePage()
            .environmentObject(CurrentUser(isLoggedIn: true, name: "nic"))
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .dark)
            
            ProfilePage()
            .environmentObject(CurrentUser(isLoggedIn: true, name: "nic"))
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .light)
        }
        
    }
}
#endif
