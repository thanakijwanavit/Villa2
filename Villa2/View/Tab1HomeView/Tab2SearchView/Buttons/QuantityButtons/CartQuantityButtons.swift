//
//  CartButton.swift
//  Villa2
//
//  Created by nic Wanavit on 4/3/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI
import CoreData

struct CartQuantityButtons: View {
    var numberOfProducts:Int{
        var totalProducts = 0
        for product in productCores{
            totalProducts += product.quantityInCart
        }
        return totalProducts
    }
    var fetchRequest: FetchRequest<ProductCore>
    var productCores: FetchedResults<ProductCore>{
        fetchRequest.wrappedValue
    }
    @Binding var isCheckout:Bool
    @Binding var showModal:Bool
    
    init(isCheckout:Binding<Bool>, showModal:Binding<Bool>){
        let request: NSFetchRequest<ProductCore> = ProductCore.fetchRequest()
        request.fetchLimit = 100
        let predicate = NSPredicate(format: "isInCart == TRUE")
        request.predicate = predicate
        request.sortDescriptors = []
        self.fetchRequest = FetchRequest<ProductCore>(fetchRequest: request)
        
        self._isCheckout = isCheckout
        self._showModal = showModal
    }
    var body: some View {
        ZStack(alignment: .topTrailing){
            HStack{
                Image(systemName: self.numberOfProducts > 0 ? "cart.fill":"cart")
                .resizable()
                .frame(width: 20, height: 20, alignment: .topTrailing)
                Spacer()
            }
            .frame(width: 28, height: 30)
            if self.numberOfProducts > 0 {
                ZStack{
                    Circle()
                        .foregroundColor(.white)
                    
                    Image(systemName: "\(self.numberOfProducts <= 50 ? String(self.numberOfProducts):"plus").circle.fill")
                    .resizable()
                }
                    .frame(width: 15, height: 15, alignment: .topTrailing)
                    .foregroundColor(.red)
            }
        }
//        .onTapGesture {
//            self.isCheckout = true
//            self.showModal = true
//        }
    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        CartQuantityButtons(isCheckout: .constant(false), showModal: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}

