//
//  UIBarItem+Extension.swift
//  PhotoVault
//
//  Created by CherryPie Studio on 06.06.2018.
//  Copyright © 2018 CherryPie Studio. All rights reserved.
//

import UIKit

extension UIBarItem {
    @IBInspectable
    public var localizedValue: String {
        get {
            if let title = title {
                return title
            }
            return ""
        }
        set {
            title = NSLocalizedString(newValue, comment: "")
        }
    }
}
