//
//  UserDefaults+Extension.swift
//  Alias
//
//  Created by CherryPie Studio on 04.07.2018.
//  Copyright © 2018 CherryPie Studio. All rights reserved.
//

import UIKit

extension UserDefaults {
    func hasValue(forKey key: String) -> Bool {
        if let _ = value(forKey: key) {
            return true
        }
        return false
    }
}
