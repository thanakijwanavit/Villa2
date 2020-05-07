////
////  SingleProductView.swift
////  Villa2
////
////  Created by nic Wanavit on 3/13/20.
////  Copyright © 2020 tenxor. All rights reserved.
////
//
//import SwiftUI
//
//struct SingleProductView: View {
//    @EnvironmentObject var productList:ProductList
//    @Binding var productID:Int
//    
//    var product:ProductRaw{
//        get {
//            return self.productList.products[self.productID]
//        }
//    }
//    var body: some View {
//        var quantity: Binding<Int>  = Binding(get: {
//            return self.productList.products[self.productID].quantityInCart
//        }, set: {
//            self.productList.products[self.productID].quantityInCart = $0
//        })
//        
//    return GeometryReader{ g in
//    NavigationView{
//        Form{
//            Section{
//                SingleProductImageSection(productID: self.$productID, g: g)
//            }
//            .frame(alignment: .center)
//            
//            Section {
//                VStack (alignment: .leading) {
//                    HStack(alignment: .center){
//                        Text("Name").font(.headline)
//                            .frame(width: g.size.width/3)
//                        
//                        Text(self.product.name)
//                            .font(.subheadline)
//                            .frame(width: g.size.width * 2/3, alignment: .leading)
//                    }
//                    
//                    HStack(alignment: .center){
//                    Text("Price").font(.headline)
//                        .frame(width: g.size.width/3)
//                    
//                    Text(self.product.priceDescription)
//                        .font(.subheadline)
//                        .frame(width: g.size.width * 2/3, alignment: .leading)
//                    }.padding(.vertical)
//                    
//                    
//                    
//                    
//                    // product quantity button
//                    HStack {
//                        Spacer()
//                        ProductQuantityButton(product: self.product, quantity: quantity)
//                        Spacer()
//                    }.padding(.vertical)
//                    
//                    
//                    
//                    HStack {
////                        Spacer()
//                        ZStack{
//                            Color.blue
//                            Button(action : {}){
//                                Text("Buy Now")
//                                    .foregroundColor(.white)
//                                    .font(.headline)
//                            }.buttonStyle(BorderlessButtonStyle())
//                        }
//                        .frame(width: g.size.width)
////                        Spacer()
//                    }.padding(.vertical)
//                        
//                        
//                        HStack {
//                            Spacer()
//                            Button(action : {}){
//                                Text("Add to Cart")
//                            }
//                            .frame(width: g.size.width)
//                            Spacer()
//                        }.padding(.vertical)
//                        
//                }
//            
//            
//            Section {
//                VStack(alignment: .center){
//                    Text("Description").font(.headline)
//                        .frame(width: g.size.width/3)
//                        .padding()
//                    
//                    Text(self.product.description ?? "")
//                        .font(.subheadline)
//                        .frame(width: g.size.width * 8/10, alignment: .leading)
//                }
//            }
//            
//            
//            
//        }
//        .navigationBarTitle(Text(self.productList.products[self.productID].name), displayMode: .automatic)
//            .navigationBarItems(trailing: Button(action : {
//            
//        }){
//            Capsule()
//            })
//    }}}
//    }
//}
//
//
//
//struct SingleProductImageSection: View {
//    @EnvironmentObject var productList:ProductList
//    @Binding var productID:Int
//    var g: GeometryProxy
//    var body: some View {
//        HStack{
//            Spacer()
//        Image(uiImage: self.productList.products[self.productID].image)
//            .resizable()
//            .frame(width: g.size.width * (3/5), height: g.size.width * (3/5), alignment: .center)
//            Spacer()
//        }
//    }
//}
//
//
//struct SingleProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleProductView(productID: .constant(0))
//            .environmentObject(SampleProductList.productList)
//    }
//}
