//
//  HistViewController.swift
//  WeatherMood
//
//  Created by Wesley Espinoza on 8/1/19.
//  Copyright © 2019 HazeWritesCode. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class HistViewController: UITableViewController {
    
    lazy var realm:Realm = {
        return try! Realm()
    }()
    
    var notes: Results<Note>!{
        didSet {
            tableView.reloadData()
        }
    }
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = NoteManager.retrieveNotes()
        
        tableView.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([dismissButton.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor, constant: 15),
            dismissButton.trailingAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.trailingAnchor, constant: -15)])
        
        
    }
    
    
    @objc func dismissButtonPressed() {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteCell
        let note = notes[indexPath.row]
        let mood = notes[indexPath.row].image
        switch mood {
        case .happy:
            cell.moodImageView.image = UIImage(named: "happy")
        case .neutral:
            cell.moodImageView.image = UIImage(named: "meh")
        case .sad:
            cell.moodImageView.image = UIImage(named: "sad")
        default:
            cell.moodImageView.image = UIImage(named: "meh")
        }
        cell.noteTitle.text = note.title
        cell.timeStamp.text = note.timeStamp
        cell.temp.text = note.temp
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            
            switch identifier {
            case "presentNoteSegue":
                let indexPath = tableView.indexPathForSelectedRow!
                // 2
                let note = notes[indexPath.row]
                let noteViewController = segue.destination as! NoteViewController
                noteViewController.note = note
                break
                
            default:
                print("Unknown identifier")
                break
            }
        }
    }
    
    
    
    
    @IBAction func unwindToHistViewController(segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
    }

    
}
