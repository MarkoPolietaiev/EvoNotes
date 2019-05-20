//
//  UILabel+Extension.swift
//  PhotoVault
//
//  Created by CherryPie Studio on 06.06.2018.
//  Copyright © 2018 CherryPie Studio. All rights reserved.
//

import UIKit

extension UILabel {
    @IBInspectable
    var isUppercased: Bool {
        get {
            return false
        }
        set {
            if let text = self.text {
                self.text = newValue ? text.uppercased() : text.lowercased()
            }
        }
    }
    
    func setupLineSpacing(_ lineSpacing: CGFloat) {
        if let text = self.text {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpacing
            style.alignment = self.textAlignment
            var string = NSAttributedString.init(string: text)
            string = string.applying(attributes: [.paragraphStyle : style], toRangesMatching: text)
            self.attributedText = string
        }
    }
}
