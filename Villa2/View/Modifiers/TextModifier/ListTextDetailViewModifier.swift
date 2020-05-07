//
//  ListTextDetailViewModifier.swift
//  Villa2
//
//  Created by nic Wanavit on 4/7/20.
//  Copyright © 2020 tenxor. All rights reserved.
//


import Foundation
import SwiftUI
import CoreData
struct ListTextDetailViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .lineLimit(2)
            .frame(alignment: .leading)

    }
}
