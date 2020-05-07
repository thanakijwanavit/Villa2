//
//  AddToCartButton.swift
//  Villa2
//
//  Created by nic Wanavit on 4/5/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct AddToCartButton: View {
    @Binding var quantityInCart: Int
    var width: CGFloat
    var body: some View {
        ZStack(alignment: .leading){
                    HStack(alignment: .center) {
                        
                        // remove button
                        Button(action: {
        //                    Actions
                            self.quantityInCart += 1
                        }) {
                            Text(self.width > 100 ? "Add to Cart": "Add")
                            .frame(height: self.width/3)
                        }

                    }
                    .onTapGesture {
                        self.quantityInCart += 1
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .frame(width: width, height: 33, alignment: .center)
                    .padding(.horizontal)
                    .overlay(Capsule().stroke(
                        Color.blue.opacity(0.5),lineWidth: 5)
                        )
                }

        
    }
}

struct AddToCartButton_Previews: PreviewProvider {
    static var previews: some View {
        AddToCartButton(quantityInCart: .constant(2), width: 100)
    }
}
