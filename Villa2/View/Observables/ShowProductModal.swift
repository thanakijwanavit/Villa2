//
//  ShowProductModal.swift
//  Villa2
//
//  Created by nic Wanavit on 3/29/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI

class ShowProductModal:ObservableObject{
    @Published var product:ProductCore?
    @Published var isDisplayed:Bool = false
}
