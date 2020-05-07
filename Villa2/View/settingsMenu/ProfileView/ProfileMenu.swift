//
//  ProfileMenu.swift
//  Villa2
//
//  Created by nic Wanavit on 4/5/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

class UserProfile: Hashable {
    static func == (lhs: UserProfile, rhs: UserProfile) -> Bool {
        return lhs.hashValue > rhs.hashValue
    }
    
    
    var userId:String = "abcd1234"
    var SampleProfileData = [
        "name":"nic".capitalizingFirstLetter(),
        "memberId":"1234",
        "birthday": "1 feb 2020",
        "membership": "gold",
        "points": "123"
    ]
    var image = UIImage(named: "Nic")
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.userId)
    }
}




struct ProfileMenu: View {
    var userProfile:UserProfile = UserProfile()
    
    var body: some View {
        let keys = userProfile.SampleProfileData.map{$0.key}
        let values = userProfile.SampleProfileData.map {$0.value}
        return GeometryReader{ g in
            List {
                Image(uiImage: self.userProfile.image ?? UIImage(named: "VillaPlaceholder")!)
                    .scaledToFill()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white , lineWidth: 10).shadow(radius: 2).opacity(0.6))
                    .shadow(radius: 2)
                    .padding()
                    .frame(width: g.size.width, height: g.size.width, alignment: .center)
                .listRowInsets(EdgeInsets(top: -20, leading: 0, bottom: -20, trailing: -20))
                
                ForEach(keys.indices) {index in
                    HStack {
                        Text(keys[index].capitalizingFirstLetter()).font(.headline)
                            .frame(width: 150, alignment: .leading)
                        
                        Text("\(values[index])").font(.subheadline)
                            .frame(alignment: .leading)
                    }
                }
            }
        }
    }
}

struct ProfileMenu_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMenu()
    }
}
