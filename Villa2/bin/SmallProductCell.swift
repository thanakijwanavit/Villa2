//
//import SwiftUI
//
//struct SmallProductCell: View {
//    @EnvironmentObject var rootGeometry:RootGeometry
//    @EnvironmentObject var productList:ProductList
//    @State var product:ProductRaw
//
//
//    var body: some View {
//        
//        let quantity = Binding<Int>(get: {
//            return self.productList.getQuantityInCart(sku: self.product.sku)
//            
//        },
//            set: {
//                self.productList.setQuantityInCart(sku: self.product.sku, quantity: $0)
//                debugPrint("quantity in cart is set to:", $0)
//                debugPrint("test getting product quantity:", self.productList.getQuantityInCart(sku: self.product.sku))
//
//        })
//        
//        
//        return GeometryReader{ g in
//                HStack(alignment: .top){
//                
//                VStack(alignment: .center){
//                    // product image
//                    Button(action: {
//                    }){
//                        ProductImage(overrideWidth: Float(g.size.width/8) ,product: self.product)
//                        .frame(width: g.size.width/4)
//                        .scaledToFit()
//
//                    }
//                    .buttonStyle(BorderlessButtonStyle())
//                    
//                    
//                    HStack{
//                                    
//                        // all button suite
//                        ProductQuantityButton(product: self.product, quantity: quantity)
//                            .padding()
//                            .animation(nil)
//
//                        
//                        
//                        //add item to favourite
//    //                    Button(action: {
//    //                        self.product.isFavourite.toggle()
//    //                    }){
//    //                        Image(systemName: product.isFavourite ? "star":"star.fill")
//    //                    }
//    //                    .padding()
//    //                    .buttonStyle(BorderlessButtonStyle())
//
//
//                    }
//                }
//
//                // product description and button
//                ProductDescription(product: self.$product, quantity: quantity)
//    //                .environmentObject(self.rootGeometry)
//    //                .environmentObject(self.productList)
//            }
//        }
//
//    }
//    
//    private func imageWidth()->CGFloat{
//        return (self.rootGeometry.geometry?.size.width ?? 300) / 3
//    }
//}
//
//struct SmallProductCell_Previews: PreviewProvider {
//    static var previews: some View {
//        Group{
//            SmallProductCell(product: SampleProductList.products[0])
//                .background(Color(.systemBackground))
//                .environment(\.colorScheme, .dark)
//                .previewLayout(.sizeThatFits)
//            
//            SmallProductCell(product: SampleProductList.products[1])
//            .previewLayout(.sizeThatFits)
//            
//            SmallProductCell(product: SampleProductList.products[0])
//                .previewLayout(.sizeThatFits)
//
//        }
//        .environmentObject(SampleProductList.productList)
//        .environmentObject(RootGeometry(geometry: nil))
//        .previewLayout(.sizeThatFits)
//    }
//}
