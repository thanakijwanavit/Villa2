//
//  ProductImage.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct ProductImage: View {
    @EnvironmentObject var rootGeometry:RootGeometry
    var product: ProductRaw
    var body: some View {
        ZStack(alignment: .center){
            Color(.white)
                .frame(width: self.imageWidth()+15 , height: self.imageWidth()+15 )
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
            )
//                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.green.opacity(0.2), lineWidth: 5)
                )
                .shadow(radius: 5)
                
            Image(uiImage: self.product.image)
                .renderingMode(.original)
                .frame(width: self.imageWidth(), height: self.imageWidth())
                .foregroundColor(.purple)
                .padding()            }
        }
    
    private func imageWidth()->CGFloat{
        return (self.rootGeometry.geometry?.size.width ?? 300) / 4
    }
}

struct ProductImage_Previews: PreviewProvider {
    static var previews: some View {
        ProductImage(product: SampleProductList.products[0])
            .environmentObject(RootGeometry(geometry: nil))
    }
}
