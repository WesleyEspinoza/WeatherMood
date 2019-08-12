//
//  Note.swift
//  WeatherMood
//
//  Created by Wesley Espinoza on 8/6/19.
//  Copyright © 2019 HazeWritesCode. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

@objc enum Emotions: Int {
    case sad
    case happy
    case neutral
    
}

class Note: Object {
    @objc dynamic var title = ""
    @objc dynamic var desc = ""
    @objc dynamic var image = Emotions.neutral
    @objc dynamic var temp = ""
    @objc dynamic var timeStamp = ""
}
