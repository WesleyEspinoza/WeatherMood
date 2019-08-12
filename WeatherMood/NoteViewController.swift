//
//  NoteViewController.swift
//  WeatherMood
//
//  Created by Wesley Espinoza on 8/7/19.
//  Copyright © 2019 HazeWritesCode. All rights reserved.
//

import Foundation
import UIKit

class NoteViewController: UIViewController {
    
    var emotion: Emotions = .neutral
    var temp: String!
    var note: Note?
    @IBOutlet weak var titleTextBox: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let note = note {
            titleTextBox.text = note.title
            descTextView.text = note.desc
            temp = note.temp
            emotion = note.image
        } else {
            titleTextBox.text = ""
            descTextView.text = ""
        }

        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let note = Note()
        let date = Date()
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        let dayOfMonth = components.day
        dateFormatter.dateFormat = "EEEE"
        let dayOfTheWeekString = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "LLLL"
        let monthString = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)
        
        
        note.desc = descTextView.text
        note.title = titleTextBox.text ?? ""
        note.image = emotion
        note.temp = temp
        note.timeStamp = "\(dayOfTheWeekString), \(monthString) \(String(describing: dayOfMonth)), \(yearString)"
        NoteManager.addNote(note: note)
        dismiss(animated: true, completion: nil)
    }
    
}
