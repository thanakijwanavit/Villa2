//
//  RootGeometry.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI

class RootGeometry:ObservableObject{
    @Published var geometry:GeometryProxy?
    
    init(geometry:GeometryProxy?){
        self.geometry = geometry
    }
}
