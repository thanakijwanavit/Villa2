//
//  ZoomedImageView.swift
//  Villa2
//
//  Created by nic Wanavit on 4/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct ZoomedImageView: View {
    var product:ProductCore
//    @State private var zoomValue:CGFloat = 1
    @GestureState private var zoomValue:CGFloat = 1
    @State var currentZoomValue:CGFloat = 1
//    @GestureState var magnifyBy = CGFloat(1.0)
//    @State private var dragAmount = CGSize.zero
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    @State private var enabled = false
    var body: some View {
        GeometryReader{g in
            VStack{
//                ModalViewIndicator()
                
                KFImage(self.product.wrappedUrl)
                .placeholder{
                    KFImage(self.product.wrappedAlternativeUrl)
                        .placeholder{
                            ImagePlaceholder.productPlaceholderImage()
                        }
                        .resizable()
                        .scaledToFit()
                }
                .scaleEffect(CGFloat(self.currentZoomValue))
                .offset(self.currentPosition)
                .animation(Animation.default.delay( 0.01))
                .gesture(
                    DragGesture()
                        .onChanged {
                            let translation = $0.translation
//                            self.dragAmount = translation
                            self.currentPosition = CGSize(width: translation.width + self.newPosition.width, height: translation.height + self.newPosition.height)
                            }
                        .onEnded { value in
                            self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                            self.newPosition = self.currentPosition
//                            self.dragAmount = .zero
//                            self.enabled.toggle()
                            }
                    .simultaneously(with:
                        MagnificationGesture()
                            .onChanged({ (newZoom) in
                                self.currentZoomValue = newZoom
                            })
                            .updating(self.$zoomValue, body: { (currenState, gestureState, transaction) in
                                gestureState = currenState
                            })
                            .onEnded({ (magnificationValue) in
                                debugPrint(magnificationValue)
                                debugPrint(self.zoomValue)
                                self.currentZoomValue = magnificationValue
                            })
                    )
                )
                
                Spacer()
                
                Slider(value: self.$currentZoomValue,in: 0.5...3.0)
                    .padding()
                
            }
            .onAppear{
                debugPrint(self.product)
            }
            
//            .pinchToZoom()
        }
    }
}

struct ZoomedImageView_Previews: PreviewProvider {
    static var previews: some View {
        ZoomedImageView(product: SampleProductCore.productCore)
    }
}
