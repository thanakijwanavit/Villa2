//
//  ImageExtension.swift
//  Villa2
//
//  Created by nic Wanavit on 4/3/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import Foundation
import SwiftUI
extension UIImage{
    func resizedImage(targetSize:CGSize)->UIImage{
        return ImageManipulation.resizeImage(image: self, targetSize: targetSize)
    }
}


extension UIImage{
    func imageByMakingWhiteBackgroundTransparent() -> UIImage? {

        let image = UIImage(data: self.jpegData(compressionQuality: 1.0)!)!
        let rawImageRef: CGImage = image.cgImage!

        let colorMasking: [CGFloat] = [222, 255, 222, 255, 222, 255]
        UIGraphicsBeginImageContext(image.size);

        let maskedImageRef = rawImageRef.copy(maskingColorComponents: colorMasking)
        UIGraphicsGetCurrentContext()?.translateBy(x: 0.0,y: image.size.height)
        UIGraphicsGetCurrentContext()?.scaleBy(x: 1.0, y: -1.0)
        UIGraphicsGetCurrentContext()?.draw(maskedImageRef!, in: CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return result

    }
}
