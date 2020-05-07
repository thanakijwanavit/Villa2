//
//  TabStatus.swift
//  Villa2
//
//  Created by nic Wanavit on 3/14/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation

class TabStatus: ObservableObject{
    @Published var tabChoice:TabChoice {
        didSet {
            UserDefaults.standard.set(self.tabChoice.rawValue, forKey:self.tabStatusKey)
        }
    }
    
    init(){
        let savedTab = UserDefaults.standard.string(forKey: self.tabStatusKey) ?? TabChoice.tab1.rawValue
        self.tabChoice = TabChoice(rawValue: savedTab) ?? TabChoice.tab1
    }
    let tabStatusKey = "tabStatusKey"
    
}


enum TabChoice:String{
    case tab1 = "tab1"
    case tab2 = "tab2"
    case tab3 = "tab3"
    case cart = "cart"
}
