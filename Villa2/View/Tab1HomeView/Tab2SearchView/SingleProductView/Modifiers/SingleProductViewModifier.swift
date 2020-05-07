//
//  SingleProductViewModifiers.swift
//  Villa2
//
//  Created by nic Wanavit on 4/7/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI
struct SingleProductCoreImageModifier: ViewModifier {
    @Binding var largeImage:Bool
    @Binding var imageRotation: Double
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.init(degrees: self.imageRotation), axis: (x: 0, y: 1, z: 0))
            .onTapGesture {
                withAnimation(.interpolatingSpring(stiffness: 50, damping: 5)){
                    self.largeImage.toggle()
                    if self.largeImage {
                        self.imageRotation = 10
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.interpolatingSpring(stiffness: 2, damping: 1)){
                                self.imageRotation = 0
                                }
                            }
                        } else {
                            self.imageRotation = 0
                        }
                    }
                }
            .pinchToZoom()
    }
}
