//
//  User.swift
//  swiftuiHE
//
//  Created by nic Wanavit on 3/10/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

class CurrentUser:ObservableObject {
    @Published var isLoggedIn = false
    @Published var name = ""
    @Published var age = "10"

    
    init(isLoggedIn:Bool, name:String){
        self.isLoggedIn = isLoggedIn
        self.name = name
    }
    init(){
    }
    
}

class PresentationStatus:ObservableObject {
    @Published var profile = false
    
}



class SampleCurrentUser{
    static var user = CurrentUser(isLoggedIn: true, name: "nic")
}

