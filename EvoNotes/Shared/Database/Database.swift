//
//  Database.swift
//  EvoNotes
//
//  Created by Marko Polietaiev on 5/19/19.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit
import RealmSwift
import Zip
import SwifterSwift

class Database: NSObject {
    var realm: Realm!
    
    private static let sharedInstance: Database = {
        let instanse = Database()
//        instanse.openRealm()
        instanse.initRealm()
        return instanse
    }()
    
    static func shared() -> Database {
        return sharedInstance
    }
    
    private func initRealm() {
        do {
            realm = try Realm()
        } catch let error {
            print("ERROR: \(error.localizedDescription)")
        }
    }
    
//    private func openRealm() {
//        Database.migrateRealm(1)
//        let defaultRealmPath = Realm.Configuration.defaultConfiguration.fileURL!
//        let bundleRealmPath = R.file.realmZip()!
//        if !FileManager.default.fileExists(atPath: defaultRealmPath.relativePath) {
//            do {
//                try Zip.unzipFile(bundleRealmPath, destination: defaultRealmPath.deletingLastPathComponent(), overwrite: true, password: nil)
//            } catch let error {
//                print("error copying seeds: \(error)")
//            }
//        }
//    }
}

extension Database {
    func getNotesCount() -> Int {
        let count = realm.objects(Note.self).count
        return count
    }
    
    func getNotes(from: Int?, to: Int?) -> [Note] {
        //PAGINATION
        var notesArray:[Note] = []
        if let to = to, let from = from {
            let notes = self.realm.objects(Note.self)[from..<to]
            notesArray = Array.init(notes)
        } else {
            let notes = realm.objects(Note.self)
            notesArray = Array.init(notes)
        }
        return notesArray
    }
    
    func getNoteByID(_ id: Int) -> Note? {
        let notes = realm.objects(Note.self)
        return notes.single(where: { (obj) -> Bool in
            return obj.id == id
        })
    }
}

extension Database {
    func saveNote(_ note: Note) {
        do {
            try realm.safeWrite {
                realm.add(note)
            }
        } catch let error {
            print("ERROR (saveNotes): \(error.localizedDescription)")
        }
    }
    
    func deleteNote(_ note: Note) {
        do {
            try realm.safeWrite {
                realm.delete(note)
            }
        } catch let error {
            print("ERROR (deleteNote): \(error.localizedDescription)")
        }
    }
}

