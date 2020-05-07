//
//  CartViewHeaderCell.swift
//  Villa2
//
//  Created by nic Wanavit on 3/14/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI


struct CartViewHeaderCell: View {
//    @EnvironmentObject var productList:ProductList
    @State var animationAmount:Double = 1
    var cartTotal:Float
    var numberOfProducts:Int
    var body: some View {
        
        VStack{
            HStack {
                Text("Subtotal ( \(self.numberOfProducts) items):")
                Text("฿ \(self.cartTotal.noDecimalPoints)")
                    .foregroundColor(.orange)
                    .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
//                    .scaleEffect(animationAmount)
//                    .animation(
//                        Animation.easeInOut(duration: 1.8)
//                            .delay(0.2)
//                            .repeatForever(autoreverses: true)
//                    )
                    .onAppear {
                        withAnimation(  Animation.easeInOut(duration: 2)
                            .repeatForever(autoreverses: true)
                        ){
                            self.animationAmount = 20
                        }
                }
                    

            }
        }
        .font(.system(size: 20, weight: .heavy, design: .default))
        .padding()
    }
}

struct CartViewHeaderCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CartViewHeaderCell(cartTotal: 5.0, numberOfProducts: 5)
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .light)
            .previewLayout(.sizeThatFits)
            
            CartViewHeaderCell(cartTotal: 4.0, numberOfProducts: 5)
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .dark)
            .previewLayout(.sizeThatFits)
        }
//        .environmentObject(SampleProductList.productList)
    }
}
