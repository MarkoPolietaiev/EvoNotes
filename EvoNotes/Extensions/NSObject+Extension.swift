//
//  NSObject+Extension.swift
//  PhotoVault
//
//  Created by CherryPie Studio on 06.06.2018.
//  Copyright © 2018 CherryPie Studio. All rights reserved.
//

import UIKit

extension NSObject {
    public class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    public var className: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
    
    func setTimeOut(_ time: Double, callBack: @escaping() -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time / 1000) {
            callBack()
        }
    }
    
    func calculateTimeWithText(text: String) -> TimeInterval {
        if text.count > 0 {
            let minTime: Double = 1500
            let maxTime: Double = 5000
            let currentTime = Double(Double(text.count) * 0.06 * 1000)
            var time = currentTime
            
            if time > maxTime {time = maxTime}
            if time < minTime {time = minTime}
            
            return time / 1000
        }
        return 0
    }
}
