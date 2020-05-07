//
//  SearchTopViewIconButtonStyle.swift
//  Villa2
//
//  Created by nic Wanavit on 4/14/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI
import KingfisherSwiftUI
struct TopIconsButtonStyle: ButtonStyle {
    
    var activated:Bool
    func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
        .padding()
        .foregroundColor(.white)
        .background(configuration.isPressed ? Color.red : self.activated ? Color.red: Color(.sRGB, white: 0, opacity: 0.01) )
        .frame(height: 100)
        .cornerRadius(50.0)
    }
}
