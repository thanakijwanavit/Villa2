//
//  SeachSideViewButtonStyle.swift
//  Villa2
//
//  Created by nic Wanavit on 4/14/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI
import KingfisherSwiftUI

struct SideIconsButtonStyle: ButtonStyle {
    
    var activated:Bool
    var width:CGFloat
    
    func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
        .foregroundColor(.white)
        .background(configuration.isPressed ? Color.red : self.activated ? Color.red:Color.gray)
        .cornerRadius(10)
//        .frame(width: self.width)
    }
}
