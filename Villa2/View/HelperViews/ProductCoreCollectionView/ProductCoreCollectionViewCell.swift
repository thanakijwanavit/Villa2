//
//  ProductCell.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct ProductCoreCollectionViewCell: View {
    var product:ProductCore
    @Binding var disableImageAnimation:Bool
    @Binding var sidebar:Bool
    @EnvironmentObject var showProductModal:ShowProductModal
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var productCoreWrapper:ProductCoreWrapper
    var isSingleProduct:Bool
    @State var showModal:Bool = false
    var globalG: GeometryProxy
    var imageWidth:CGFloat = 200
    
    
    init(product:ProductCore,disableImageAnimation:Binding<Bool>, sidebar:Binding<Bool>, imageWidth: CGFloat?, globalG:GeometryProxy, isSingleProduct:Bool){
        let productCoreWrapper = ProductCoreWrapper(productCore: product)
        self.productCoreWrapper = productCoreWrapper
        self.product = productCoreWrapper.productCore
        
        self._disableImageAnimation = disableImageAnimation
        self._sidebar = sidebar
        
        if let imageWidth = imageWidth {
            self.imageWidth = imageWidth
        }
        
        self.globalG = globalG
        self.isSingleProduct = isSingleProduct
    }
    
    var body: some View {
    let quantity = Binding<Int>(get: {
            return self.product.quantityInCart
        },
            set: {
                self.product.quantityInCart = $0
                try? self.moc.save()
        })
        
        
        return
            GeometryReader{ g in
            VStack(alignment:.center,spacing: 5){
                //image and quantity selector
                VStack(alignment: .leading) {
                    NavigationLink(destination: SingleProductCoreView(product: self.product, showModal: self.$showModal)) {
                        
                        ProductCoreImage(disableImageAnimation: self.$disableImageAnimation, width: self.imageWidth , productCore: self.product)
                        .opacity(1)
                        .rotation3DEffect(.init(degrees: Double(g.frame(in: .global).minX - g.size.width) * 0.05), axis: (x: 0, y: 10, z: 0))
                        .scaleEffect(self.scaleValue(g: g, globalg: self.globalG))
                        .padding(.horizontal)
                    }
                    .isDetailLink(false)
                    
                    
                }
                //description and price
                VStack(alignment: .center){
                    Text("\(self.product.name ?? "")")
                        .lineLimit(3)
                        .modifier(MultilineTextModifier())
                        .fixedSize(horizontal: false, vertical: true)
                        .allowsTightening(true)
                        .truncationMode(.tail)
                        .font(.body)
                        .background(Color(UIColor.systemBackground))
                        .minimumScaleFactor(0.5)
                        .onTapGesture {
                            self.showSingleProduct()
                        }
                        .frame(width: self.imageWidth - 20, height: 100)
                    
                        

                    
                    Text(self.product.priceDescription)
                        .lineLimit(1)
                        .allowsTightening(true)
                        .font(.footnote)
                        .frame(width: self.imageWidth)
                    
                    HStack{
                        if !self.product.isInCart {
                            AddToCartButton(quantityInCart: quantity, width: self.imageWidth - 70)
                                .padding(.top, 10)
                        } else {
                            ProductCoreQuantityButton(product: self.product, quantity: quantity, width: self.imageWidth - 50)
                        }
                    }
                    
                }
            }
            .animation(.easeInOut(duration: 1))
            .font(.system(size: 20, weight: .semibold, design: .default))
            
        }
    }
    
    func scaleValue(g:GeometryProxy,globalg:GeometryProxy)->CGFloat{
        let localMid = g.frame(in: .global).midX
        let globalMid = globalg.frame(in: .global).midX
        let diff = localMid - globalMid
        let isNegative = (localMid - globalMid) < 0
        let multiplier:CGFloat = 0.0003
        let initial:CGFloat = 1
        if isNegative {
            return initial - CGFloat(-diff) * multiplier
        } else {
            return initial - CGFloat(diff) * multiplier
        }
    }
    
    
    func scale(g: GeometryProxy)->CGFloat{
        let distance = (g.frame(in: .global).minX - g.size.width)
        if -80...80 ~= distance{
            return 1
        } else if -200...200 ~= distance{
            return 0.9
        } else {
            return 0.8
        }
    }
    
    
    func showSingleProduct(){
        debugPrint("tapped")
        if isSingleProduct{
            withAnimation(Animation.linear(duration: 1)){
                self.showProductModal.product = self.product
            }
        } else {
            
        }
    }
    
    func reloadUI(){
        DispatchQueue.main.async {
            self.sidebar.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.sidebar.toggle()
            }
        }
    }
}







#if DEBUG
struct ProductCoreCollectionViewCell_Previews: PreviewProvider {
    static var previews: some View {
        let productCore = SampleProductCore.productCore
        
        return GeometryReader { g in
            Group {
                ProductCoreCollectionViewCell(product: productCore, disableImageAnimation: .constant(true), sidebar: .constant(false), imageWidth: 200, globalG: g, isSingleProduct: false)
            }
            .modifier(DarkSubViewPreviewModifier(context: SampleProductCore.context))
        }
    }
}

#endif





