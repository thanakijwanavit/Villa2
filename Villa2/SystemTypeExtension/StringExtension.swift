//
//  StringExtension.swift
//  Villa2
//
//  Created by nic Wanavit on 3/27/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation

extension String{
    var floatValue:Float{
        if let float = Float(self){
            return float
        } else {
            debugPrint("error converting string \(self) to float \n please check in stringExtension file , returning 0")
            return Float(0)
        }
    }
}

extension String: Error {
    
}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

//pat first letter
extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
