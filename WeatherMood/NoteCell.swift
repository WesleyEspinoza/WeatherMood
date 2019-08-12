//
//  noteCell.swift
//  WeatherMood
//
//  Created by Wesley Espinoza on 8/7/19.
//  Copyright © 2019 HazeWritesCode. All rights reserved.
//

import Foundation
import UIKit
class NoteCell: UITableViewCell {
    @IBOutlet weak var moodImageView: UIImageView!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var noteTitle: UILabel!
    var mood: Emotions = .neutral
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    
}
