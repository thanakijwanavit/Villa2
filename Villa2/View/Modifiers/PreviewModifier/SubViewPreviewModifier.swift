//
//  SuperPreviewModifier.swift
//  Villa2
//
//  Created by nic Wanavit on 4/7/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
struct SubViewPreviewModifier: ViewModifier {
    var context:NSManagedObjectContext
    func body(content: Content) -> some View {
        content
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .light)
            .previewLayout(.sizeThatFits)
            .environment(\.managedObjectContext, context)

    }
}
