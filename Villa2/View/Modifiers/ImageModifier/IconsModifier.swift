//
//  IconsModifier.swift
//  Villa2
//
//  Created by nic Wanavit on 5/6/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI


struct IconsModifier: ImageModifier{
    func body(image: Image) -> some View {
        image
//        .renderingMode(.original)
        .resizable()
        .scaledToFit()
        .frame(width: 30, height: 30, alignment: .center)
    }
}
