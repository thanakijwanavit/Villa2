//
//  ProductCoreTableCell.swift
//  Villa2
//
//  Created by nic Wanavit on 3/28/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct ProductCoreTableCell: View {
    var product:ProductCore
    var width:CGFloat
    
    //cat data
    @EnvironmentObject var catList:ProductCategoryList
    var mainCat:[ProductCategory] { get {self.catList.products.childrenData[0].childrenData}}
    var currentMainCat:ProductCategory? {get {self.mainCat.first { (cat) -> Bool in
        return cat.id.string == self.product.cat1 || cat.id.string == self.product.cat2 || cat.id.string == self.product.cat3 || cat.id.string == self.product.cat4
        }}}
    var currentSubCat:ProductCategory? {
        self.currentMainCat?.childrenData.first(where: { (cat) -> Bool in
            return cat.id.string == self.product.cat1 || cat.id.string == self.product.cat2 || cat.id.string == self.product.cat3 || cat.id.string == self.product.cat4
        })
    }
    
    
    @Binding var disableImageAnimation:Bool
    @Binding var sidebar:Bool
    
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var productCoreWrapper:ProductCoreWrapper
    
    @Binding var isSearching:Bool
    
    
    init(product:ProductCore,disableImageAnimation:Binding<Bool>, sidebar:Binding<Bool>, isSearching:Binding<Bool>, width:CGFloat){
        let productCoreWrapper = ProductCoreWrapper(productCore: product)
        self.productCoreWrapper = productCoreWrapper
        self.product = productCoreWrapper.productCore
        
        self._disableImageAnimation = disableImageAnimation
        self._sidebar = sidebar
        self._isSearching = isSearching
        self.width = width
    }
    
    // MARK:- main body
    
    var body: some View {
        let quantity = Binding<Int>(get: {
            return self.product.quantityInCart
        },
            set: {
                self.product.quantityInCart = $0
                try? self.moc.save()
        })
        
        
        return VStack(alignment: .leading){
            if isSearching{
                self.catLabel()
            }
            HStack(alignment:.top,spacing: 5){
                //image and quantity selector
                VStack(alignment: .leading) {
                    self.productImage()
                }
                .padding(.leading)
                //description and price
                VStack(alignment: .leading){
                    self.nameButton()
                    HStack(alignment: .center){
                        self.priceLabel()
                        Spacer()
                        if !isSearching{
                            cartOrQuantityButton(quantity: quantity, sideBar: self.sidebar, product: self.product)
                        }
                    }
                }
            }
               .font(.system(size: 20, weight: .semibold, design: .default))
        }.frame(width: self.width)
    }
    // MARK: -  UIViews
    func catLabel()-> some View {
    Text("\(self.currentMainCat?.name ?? "") -> \(self.currentSubCat?.name ?? "")")
    }
    
    func nameButton()-> some View {
        NavigationLink(destination: SingleProductCoreView(product: self.product, showModal: .constant(false))) {
            self.nameLabel()
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    func nameLabel()-> some View {
        return
            HStack{
            Text("\(product.name ?? "")")
            .font(.system(size: 20))
            .lineLimit(2)
            .padding(.trailing)
            .allowsTightening(true)
            Spacer()
        }
    }
    
    
    
    func priceLabel()-> some View {
        Text(self.product.priceDescription)
        .lineLimit(1)
        .allowsTightening(true)
        .font(.footnote)
        .frame(width:70)
        .animation(.easeInOut(duration: 1))
    }
    
    func productImage()-> some View {
        NavigationLink(destination: SingleProductCoreView(product: self.product, showModal: .constant(false))) {
        ProductCoreImage(disableImageAnimation: self.$disableImageAnimation, width: self.isSearching ? 40: 80, productCore: product)
        .opacity(1)
        .padding(.horizontal)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    // MARK: - functions
    func reloadUI(){
        DispatchQueue.main.async {
            self.sidebar.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.sidebar.toggle()
            }
        }
    }
}


struct cartOrQuantityButton: View {
    @Binding var quantity:Int
    var sideBar:Bool
    var product:ProductCore
    var isInCart:Bool {
        self.product.isInCart
    }
    var body: some View{
        HStack{
            Spacer()
            if !isInCart {
                self.addToCartButton(quantity: $quantity)
            } else {
                self.quantityButton(quantity: $quantity)
            }
            Spacer()
        }
    }
    func addToCartButton(quantity: Binding<Int>) -> some View {
        AddToCartButton(quantityInCart: quantity, width: self.sideBar ? 60 : 120)
        .padding(.horizontal, 7.0)
        .padding(.top)
    }
    func quantityButton(quantity: Binding<Int>)-> some View {
        ProductCoreQuantityButton(product: self.product, quantity: quantity, width: self.sideBar ? 60 : 120)
        .padding(.horizontal, 7.0)
    }
}



#if DEBUG
struct ProductCoreTableCell_Previews: PreviewProvider {
    static var previews: some View {
        let productCore = SampleProductCore.productCore
        
        return Group {
            
            ProductCoreTableCell(product: productCore, disableImageAnimation: .constant(true), sidebar: .constant(false), isSearching: .constant(false), width: 300)
            
            ProductCoreTableCell(product: productCore, disableImageAnimation: .constant(true), sidebar: .constant(false), isSearching: .constant(false), width: 200)
            
            ProductCoreTableCell(product: productCore, disableImageAnimation: .constant(true), sidebar: .constant(false), isSearching: .constant(false), width: 400)
        }
        .modifier(DarkSubViewPreviewModifier(context: SampleProductCore.context))
    }
}
#endif
