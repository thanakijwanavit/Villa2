//
//  SingleProductView.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct SingleProductView: View {
    @EnvironmentObject var rootGeometry:RootGeometry

    @Binding var productID:Int
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SingleProductView_Previews: PreviewProvider {
    static var previews: some View {
        SingleProductView(productID: .constant(0))
    }
}
