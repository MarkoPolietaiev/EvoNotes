//
//  UIColor+Extension.swift
//  PhotoVault
//
//  Created by CherryPie Studio on 07.06.2018.
//  Copyright © 2018 CherryPie Studio. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init(hex: Int, transparency: CGFloat = 1) {
        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        
        let red = (hex >> 16) & 0xff
        let green = (hex >> 8) & 0xff
        let blue = hex & 0xff
        self.init(red: red, green: green, blue: blue, transparency: trans)!
    }
}
