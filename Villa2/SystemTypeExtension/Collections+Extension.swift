//
//  Collections+Extension.swift
//  Villa2
//
//  Created by nic Wanavit on 4/15/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI

extension Collection {
  func enumeratedArray() -> Array<(offset: Int, element: Self.Element)> {
    return Array(self.enumerated())
  }
}
