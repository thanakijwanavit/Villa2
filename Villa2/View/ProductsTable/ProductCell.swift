//
//  ProductCell.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct ProductCell: View {
    @EnvironmentObject var rootGeometry:RootGeometry
    @EnvironmentObject var productList:ProductList
//    let productID: Int
    var product:ProductRaw
//    lazy var product: ProductRaw = {
//        return productList.products[productID]
//    }()
    var body: some View {
        HStack{
            
            ZStack{
                
                Button(action: {
                    
                }){
                    ProductImage(product: product)
                    .environmentObject(self.rootGeometry)
                }
            }

            ProductDescription(product: product)
                .environmentObject(self.rootGeometry)

        }
    }
    
//    func product()-> ProductRaw{
//        return self.productList.products[self.productID]
//    }
    private func imageWidth()->CGFloat{
        return (self.rootGeometry.geometry?.size.width ?? 300) / 4
    }
}







#if DEBUG
struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        Group{
//            ProductCell(product: SampleProductList.products[0])
//            .environmentObject(RootGeometry(geometry: nil))
//            .environment(\.colorScheme, .dark)
            
            ProductCell(product: SampleProductList.products[0])
            .environmentObject(RootGeometry(geometry: nil))
        }
    }
}

#endif
