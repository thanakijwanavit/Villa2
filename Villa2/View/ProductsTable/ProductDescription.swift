//
//  ProductDescription.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct ProductDescription: View {
    @EnvironmentObject var rootGeometry:RootGeometry
    var product: ProductRaw
    var body: some View {
        
        VStack(alignment:.leading){
            Text(product.name)
                .font(.headline)
                .padding(.leading)
                .padding(.trailing)

            
            
            Text(product.description ?? "")
                .font(.body)
                .padding(.leading)
                .padding(.trailing)
            
            HStack{
                Text(String(format: "฿ %.2f", product.price))
                    .font(.headline)
                    .padding()
                
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        
                    }){
                        Image(systemName: "plus")
                    }
                        .padding(12)
                        
                    
                    
                    Button(action: {
                        
                    }){
                        Image(systemName: "minus")
                    }
                        .padding(12)
                }
                    .overlay(
                        Capsule()
                            .stroke(Color.blue.opacity(0.2), lineWidth: 5)
                    )
                    .padding(.trailing)
            }
            
        }
        .frame(maxHeight: self.maxHeight())
    }
    
    private func maxHeight()->CGFloat{
        return (self.rootGeometry.geometry?.size.width ?? 300) / 3
    }
}


struct ProductDescription_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            ProductDescription(product: SampleProductList.products[0])
//            .environmentObject(RootGeometry(geometry: nil))
//            .environment(\.colorScheme, .dark)
            
            ProductDescription(product: SampleProductList.products[0])
            .environmentObject(RootGeometry(geometry: nil))
        }

    }
}
