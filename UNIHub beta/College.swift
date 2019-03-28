//
//  College.swift
//  UNIHub beta
//
//  Created by Niklas Pant (student LM) on 2/21/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import Foundation
import UIKit

class College {
    
    var name : String
    var location : String
    var url : String
    var averageSATScore : Float?
    var id : Int
    
    var userNotes : String?
    
    init(name: String, location: String, url : String, averageSATScore : Float?, id: Int){
        self.name = name
        self.location = location
        self.url = url
        self.averageSATScore = averageSATScore
        self.id = id
    }
    
    
}
