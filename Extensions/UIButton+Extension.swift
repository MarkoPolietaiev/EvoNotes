//
//  UIButton+Extension.swift
//  PhotoVault
//
//  Created by CherryPie Studio on 07.06.2018.
//  Copyright © 2018 CherryPie Studio. All rights reserved.
//

import UIKit

extension UIButton {
    func setImageColor(_ color: UIColor) {
        if var image = image(for: .normal) {
            image = image.withRenderingMode(.alwaysTemplate)
            setImage(image, for: .normal)
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
