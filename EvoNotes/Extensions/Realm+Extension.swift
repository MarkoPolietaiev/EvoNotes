//
//  Realm+Extension.swift
//  PhotoVault
//
//  Created by CherryPie Studio on 07.06.2018.
//  Copyright © 2018 CherryPie Studio. All rights reserved.
//

import UIKit
import RealmSwift

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}
