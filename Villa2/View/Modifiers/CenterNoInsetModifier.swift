//
//  CenterNoInsetModifier.swift
//  Villa2
//
//  Created by nic Wanavit on 4/7/20.
//  Copyright © 2020 tenxor. All rights reserved.
//


import Foundation
import SwiftUI
import CoreData
struct CenterNoInsetModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(alignment: .center)
            .listRowInsets(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 20))

    }
}
