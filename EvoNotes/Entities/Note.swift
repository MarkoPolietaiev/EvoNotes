//
//  Note.swift
//  EvoNotes
//
//  Created by Marko Polietaiev on 5/19/19.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit
import RealmSwift

class Note: Object {
    @objc dynamic private(set) var note: String = ""
    @objc dynamic private(set) var id: Int = 0
    @objc dynamic private(set) var date: Date?
    
    func setNote(_ note: String) {
        if let realm = Database.shared().realm {
            do {
                try realm.safeWrite {
                    self.note = note
                }
            } catch let error {
                print("ERROR (setNote): \(error.localizedDescription)")
            }
        }
    }
    
    func setDate(_ date: Date) {
        if let realm = Database.shared().realm {
            do {
                try realm.safeWrite {
                    self.date = date
                }
            } catch let error {
                print("ERROR (setDate): \(error.localizedDescription)")
            }
        }
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Note.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    func setup() {
        id = incrementID()
    }
}
