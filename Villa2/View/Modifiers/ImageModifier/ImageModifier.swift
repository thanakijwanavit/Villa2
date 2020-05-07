//
//  ImageModifier.swift
//  Villa2
//
//  Created by nic Wanavit on 5/6/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI
protocol ImageModifier {
    /// `Body` is derived from `View`
    associatedtype Body : View

    /// Modify an image by applying any modifications into `some View`
    func body(image: Image) -> Self.Body
}

extension Image {
    func modifier<M>(_ modifier: M) -> some View where M: ImageModifier {
        modifier.body(image: self)
    }
}
