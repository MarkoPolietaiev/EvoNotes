//
//  Database+Migration.swift
//  EvoNotes
//
//  Created by Marko Polietaiev on 5/19/19.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit
import RealmSwift

extension Database {
    static func migrateRealm(_ version: Int) {
        let config = Realm.Configuration(schemaVersion: UInt64(version))
        Realm.Configuration.defaultConfiguration = config
    }
}
