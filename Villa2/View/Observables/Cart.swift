//
//  Cart.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI

class Cart:ObservableObject{
    @Published var items:[ProductRaw] = []
}
