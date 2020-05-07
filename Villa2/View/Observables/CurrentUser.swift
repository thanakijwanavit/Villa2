//
//  User.swift
//  swiftuiHE
//
//  Created by nic Wanavit on 3/10/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI


struct UserInfo{
    var name:String?
    var age:Int?
    var isLoggedIn:Bool
    var address:String = ""
}

class CurrentUser:ObservableObject {
    @Published var userInfo:UserInfo

    
    init(isLoggedIn:Bool, name:String?){
        self.userInfo = UserInfo(name: name, isLoggedIn: isLoggedIn)
    }
    init(){
        self.userInfo = SampleCurrentUser.userInfo
    }
    
    
    var isLoggedIn:Bool {
        get {
            return self.userInfo.isLoggedIn
        }
        set (newValue){
            self.userInfo.isLoggedIn = newValue
        }
    }
    
    var name:String? {
        get {
            return self.userInfo.name
        }
        set(newValue) {
            self.userInfo.name = newValue
        }
    }
    var age:Int? {
        get {
            return self.userInfo.age
        }
        set (newValue){
            self.userInfo.age = newValue
        }
    }
    
}

class PresentationStatus:ObservableObject {
    @Published var profile = false
    
}



class SampleCurrentUser{
    static var userInfo:UserInfo = UserInfo(name: "nic", isLoggedIn: true, address: "Two E 55th St, New York, NY 10022")
    static var user: CurrentUser {
        get {
            return CurrentUser(isLoggedIn: SampleCurrentUser.userInfo.isLoggedIn, name: SampleCurrentUser.userInfo.name)
        }
    }
}

