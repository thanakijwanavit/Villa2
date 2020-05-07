//
//  Float.swift
//  Villa2
//
//  Created by nic Wanavit on 3/15/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
extension Float{
    var twoDecimalPoints:String {
        return String(format: "%.2f", self)
    }
    
    var noDecimalPoints:String {
        return String(format: "%.f", self)
    }
}
