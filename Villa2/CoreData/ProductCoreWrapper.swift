//
//  ProductCoreWrapper.swift
//  Villa2
//
//  Created by nic Wanavit on 4/3/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
class ProductCoreWrapper:ObservableObject{
    @Published var productCore:ProductCore
    init(productCore:ProductCore){
        self.productCore = productCore
    }
}
