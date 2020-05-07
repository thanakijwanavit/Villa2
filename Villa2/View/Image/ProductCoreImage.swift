//
//  ProductImageCore.swift
//  Villa2
//
//  Created by nic Wanavit on 3/28/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct ProductCoreImage: View {
    @State var overrideWidth:Float?
    @State var imageAnimation:Double = 0
    @Binding var disableImageAnimation:Bool
    var width:CGFloat
    var productCore: ProductCore
    var body: some View {
            ZStack(alignment: .center){
//                ProductImageBackground(width: imageWidth())
                    
                InnerProductCoreImage(product: productCore, width: imageWidth())
                
            }
            .animation(
                Animation
                    .easeInOut(duration: 1)
//                    .delay(0.2)
        )
//            .rotation3DEffect(self.disableImageAnimation ? Angle.degrees(0):Angle.degrees(self.imageAnimation), axis: (x: 0, y: 1, z: 0))
//            .onAppear{
//                if self.disableImageAnimation{
//
//                } else {
//                    withAnimation(.interpolatingSpring(stiffness: 2, damping: 1)){
//                        self.imageAnimation = 0
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                            withAnimation(.interpolatingSpring(stiffness: 2, damping: 1)){
//                            self.imageAnimation = 180
//                            }
//                        }
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                            withAnimation(.interpolatingSpring(stiffness: 2, damping: 1)){
//                            self.imageAnimation = 0
//                            }
//                        }
//                    }
//                }
//            }
        }
    
    private func imageWidth()->CGFloat{
        if let overrideWidth = self.overrideWidth {
            return CGFloat(overrideWidth)
        }
        return self.width
    }
}



struct InnerProductCoreImage: View {
    @Environment(\.managedObjectContext) var moc
    @State var image:UIImage = UIImage(named: IMAGE_PLACEHOLDER)!
    var product:ProductCore
    var width:CGFloat
    var body: some View {
//        Image(uiImage: self.image)
        KFImage(self.product.wrappedUrl)
            .placeholder{
//                Image("VillaPlaceholder-1")
                KFImage(self.product.wrappedUrl)
                .placeholder{
                    KFImage(self.product.wrappedAlternativeUrl)
                        .placeholder{
                            ImagePlaceholder.productPlaceholderImage()
                        }
                        .resizable()
                        .renderingMode(.original)
                        .scaledToFit()
                }
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: self.width, height: self.width)
        }
        .resizable()
        .renderingMode(.original)
        .scaledToFit()
//        .cornerRadius(width/7)
        .frame(width: self.width, height: self.width)
        .foregroundColor(.purple)
    }
}

#if DEBUG

struct ProductCoreImage_Preview: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let productCore = ProductCore(context: context)
        productCore.name = "testProduct"
        return Group {
            ProductCoreImage(disableImageAnimation: .constant(true), width: 50, productCore: productCore)

        }
    }
}
#endif



