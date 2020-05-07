//
//  ListTextTitleViewModifier.swift
//  Villa2
//
//  Created by nic Wanavit on 4/7/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
struct ListTextTitleViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .lineLimit(1)
            .frame(width: 100,alignment: .leading)

    }
}
