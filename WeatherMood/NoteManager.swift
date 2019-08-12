//
//  File.swift
//  WeatherMood
//
//  Created by Wesley Espinoza on 8/6/19.
//  Copyright © 2019 HazeWritesCode. All rights reserved.
//

import Foundation
import RealmSwift

enum RuntimeError: Error {
    case NoRealmSet
}

class NoteManager {
    var realm: Realm?
    
    static func addNote(note: Note) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(note)
        }
    }
    static func deleteNote(note: Note) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(note)
        }
    }
    
    static func updateNote(noteToBeUpdated: Note, newNote: Note) {
        let realm = try! Realm()
        try! realm.write() {
            noteToBeUpdated.title = newNote.title
            noteToBeUpdated.desc = newNote.desc
            noteToBeUpdated.timeStamp = newNote.timeStamp
        }
    }
    static func retrieveNotes() -> Results<Note> {
        let realm = try! Realm()
        return realm.objects(Note.self).sorted(byKeyPath: "timeStamp", ascending: false)
    }
}
