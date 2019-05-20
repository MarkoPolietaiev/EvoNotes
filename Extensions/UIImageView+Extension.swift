//
//  UIImageView+Extension.swift
//  PhotoVault
//
//  Created by CherryPie Studio on 11.06.2018.
//  Copyright © 2018 CherryPie Studio. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageColor(_ color: UIColor) {
        if var image = image {
            image = image.withRenderingMode(.alwaysTemplate)
            self.image = image
            tintColor = color
        }
    }
    
    @IBInspectable
    var imageTintColor: UIColor {
        get {
            return tintColor
        }
        set {
            setImageColor(newValue)
        }
    }
}

extension UIImage {
    
    var tonal: UIImage {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectTonal")!
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        let output = currentFilter.outputImage!
        let cgImage = context.createCGImage(output, from: output.extent)!
        let processedImage = UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        
        return processedImage
    }
}

