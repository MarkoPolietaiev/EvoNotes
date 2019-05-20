//
//  Database+Migration.swift
//  PhotoVault
//
//  Created by CherryPie Studio on 14.06.2018.
//  Copyright © 2018 CherryPie Studio. All rights reserved.
//

import UIKit
import RealmSwift

extension Database {

    static func migrateRealm(_ version: Int) {
        let config = Realm.Configuration(schemaVersion: UInt64(version))
        Realm.Configuration.defaultConfiguration = config
    }
}
