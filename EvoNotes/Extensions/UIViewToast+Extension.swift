//
//  UIViewToast+Extension.swift
//  Alias
//
//  Created by CherryPie Studio on 04.07.2018.
//  Copyright © 2018 CherryPie Studio. All rights reserved.
//

import UIKit

extension UIView {
    func showToastActivity(_ message: String = R.string.localizable.loading()) {
        hideToastActivity()
        makeToastActivity(message: message)
        isUserInteractionEnabled = false
    }
    
    func hideToastActivity() {
        hideToastActivity()
        isUserInteractionEnabled = true
    }
    
    func showMessage(message: String) {
        makeToast(message: message, duration: calculateTimeWithText(text: message), position: "center" as AnyObject)
    }
}
