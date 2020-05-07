//
//  SingleProductCoreView.swift
//  Villa2
//
//  Created by nic Wanavit on 3/29/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct SingleProductCoreView: View {
    var product:ProductCore{
        get {
            return self.productCoreWrapper.productCore
        }
    }
    @Environment(\.managedObjectContext) var moc
    @Binding var showModal: Bool
    @State var largeImage: Bool = false
    @State var imageRotation:Double = 0
    @ObservedObject var productCoreWrapper:ProductCoreWrapper
    @State var imagePopUp:Bool = false

    
    init(product:ProductCore, showModal:Binding<Bool>){
        let productCoreWrapper = ProductCoreWrapper(productCore: product)
        self.productCoreWrapper = productCoreWrapper
//        self.product = productCoreWrapper.productCore
        
        self._showModal = showModal
    }
    
    var body: some View {
            
        return GeometryReader{ g in
            VStack{
//                ModalViewIndicator()
            
            List{
                Spacer()
                //image
                Section{
                    VStack(alignment: .center){
                        
                        NavigationLink(destination: ZoomedImageView(product: self.product), isActive: self.$imagePopUp, label: {
                            Image(systemName: self.largeImage ? "minus.magnifyingglass":"plus.magnifyingglass")
                            .padding()
                            })
                            .buttonStyle(PlainButtonStyle())
                        
                        
                        
//                        Button(action: {
//                            self.imagePopUp = true
//
//                        }) {
//                            Image(systemName: self.largeImage ? "minus.magnifyingglass":"plus.magnifyingglass")
//                            .padding()
//                        }
//                        .sheet(isPresented: self.$imagePopUp, content: {
//                            ZoomedImageView(product: self.product)
//                        })
//
//                        .frame(width: g.size.width, alignment: .trailing)
                        
                        
                        
                        
                        
                    SingleProductCoreImageSection(product: self.product, g: g, largeImage: self.$largeImage)
                        
                        .modifier(SingleProductCoreImageModifier(largeImage: self.$largeImage, imageRotation: self.$imageRotation))
                        .frame(width: g.size.width, alignment: .center)
                    }
                    
                }
                .modifier(CenterNoInsetModifier())
                
                
                //name and price
                Section {
                    VStack (alignment: .leading) {
                        //name
                        HStack(alignment: .center){
                            
                            Text("Name")
                                .modifier(ListTextTitleViewModifier())
                            
                            Text(self.product.name ?? "")
                                .modifier(ListTextDetailViewModifier())
                            
                        }
                        //price description
                        HStack(alignment: .center){
                                
                            Text("Price")
                                .modifier(ListTextTitleViewModifier())
                            Text(self.product.priceDescription)
                                .modifier(ListTextDetailViewModifier())

                        }
                        .padding(.vertical)
                        // Notes to buyer
                        VStack(alignment:.leading){
                            Text("Notes to buyers")
                                .font(.headline)
                            Text("This is the note to buyers, put the product in the fridge and consume within 30 days, please read the labels carefully, if there is any abnormality, please do not consume")
                                .modifier(MultilineTextModifier())
                                .lineLimit(nil)
                                .padding()
                        }
                    }
                }
                        
                    // quantity buttons
                if self.productCoreWrapper.productCore.quantityInCart == 0 {
//                    add to cart button
                    HStack {
                        Spacer()
                        AddToCartButton(quantityInCart: self.$productCoreWrapper.productCore.quantityInCart, width: 120)
                        Spacer()
                    }
                    .padding(.vertical)
                } else {
                    HStack{
                        Spacer()
                        ProductCoreQuantityButton(product: self.product, quantity: self.$productCoreWrapper.productCore.quantityInCart, width: 120)
                            .padding()
                        Spacer()
                    }
                }
                
                    
                    
                    
                //buy now button
                HStack {
                    Spacer()
                    ZStack{
                        Color.blue
                            .cornerRadius(5)
                        Button(action : {}){
                            Text("Buy Now")
                                .foregroundColor(.white)
                                .font(.headline)
                        }.buttonStyle(BorderlessButtonStyle())
                    }
                    .frame(width: g.size.width/3, alignment: .center)
                    
                    Spacer()
                }
                .padding(.vertical)
                        
                
                
                            
                
                
                //pro description
                VStack(alignment: .center){
                    Text("Description")
                        .modifier(TextTitleViewModifier())
                    
                    Text(self.product.productDescription ?? "")
                        .font(.subheadline)
                        .frame(width: g.size.width * 8/10, alignment: .leading)
                }
                
                
                
                    //similar products
                    Text("Similar products")
                    .font(.headline)

                VStack {
                //name
                    ProductCoreCollectionViewTable(filter: self.product.name?.components(separatedBy: " ").first ?? "", disableImageAnimation: .constant(true), resultLimit: 10, bindingResultLimit: .constant(10), sidebar: .constant(false),cat1: "",cat2: "", width: g.size.width, isSingleProduct: true)
                .padding(.vertical, 20)
                //cat 1
                    ProductCoreCollectionViewTable(filter: "", disableImageAnimation: .constant(true), resultLimit: 10, bindingResultLimit: .constant(10), sidebar: .constant(false),cat1: self.product.cat1 ?? "",cat2: "", width: g.size.width, isSingleProduct: true)
                .padding(.vertical, 20)
                //cat 2
                    ProductCoreCollectionViewTable(filter: "", disableImageAnimation: .constant(true), resultLimit: 10, bindingResultLimit: .constant(10), sidebar: .constant(false),cat1: "",cat2: self.product.cat2 ?? "", width: g.size.width, isSingleProduct: true)
                .padding(.vertical, 20)
                }
                
            }
                .navigationBarTitle(Text(self.product.name ?? ""), displayMode: .inline)
                
            }}
        }
    }

struct SingleProductCoreImageSection: View {
    var product:ProductCore
    var g: GeometryProxy
//    @State private var dragAmount = CGSize.zero
//    @State private var enabled = false
    @Binding var largeImage:Bool
    var body: some View {
        HStack{
            if !largeImage {Spacer()}
            
            KFImage(self.product.wrappedUrl)
                .placeholder{
                    KFImage(self.product.wrappedAlternativeUrl)
                        .placeholder{
                            ImagePlaceholder.productPlaceholderImage()
                        }
                        .resizable()
                        .scaledToFit()
                }
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                
                .frame(width: largeImage ? g.size.width * 2 : g.size.width * (5/5) , height: largeImage ? g.size.width * 2 : g.size.width * (5/5), alignment: .center)
                
                .cornerRadius(10)
                   
                
            if !largeImage {Spacer()}
        }
//        .onAppear{
//            debugPrint("the product sku is",self.product.sku, "s3 link is",self.product.wrappedUrl, "magento link is", self.product.wrappedAlternativeUrl)
//        }
    }
}





struct SingleProductCoreView_Previews: PreviewProvider {
    static var previews: some View {
        
        let productCore = SampleProductCore.productCore
        
        return Group {
            SingleProductCoreView(product: productCore, showModal: .constant(true))

        }
    }
}
