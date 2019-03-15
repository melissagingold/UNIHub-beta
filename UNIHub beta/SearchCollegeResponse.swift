//
//  CollegeResponse.swift
//  UNIHub beta
//
//  Created by Niklas Pant (student LM) on 3/4/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import Foundation

struct SearchCollegeResponse: Decodable {
    var results: [SearchCollegeInformation]
}

struct SearchCollegeInformation: Decodable {
    var id : Int
    var name : String
    var city : String
    var state : String
    var school_url : String
    var sat_scores_average : Float?
}