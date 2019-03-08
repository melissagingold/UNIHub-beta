//
//  CollegeResponse.swift
//  UNIHub beta
//
//  Created by Niklas Pant (student LM) on 3/4/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import Foundation

//struct CollegeResponse: Decodable{
//    var results: [CollegeInformation]
//}
//
//struct CollegeInformation: Decodable {
//    var year: Int
//}

struct SearchCollegeResponse: Decodable {
    var results: [SearchCollegeInformation]
}

struct SearchCollegeInformation: Decodable {
    var id : Int
    var schoolname : String
    var schoolcity : String
    var schoolstate : String
}
