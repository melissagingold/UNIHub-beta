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
    var id: Int
    var name: String
    var city: String
    var state: String
    var school_url: String
    var sat_scores_average: Float?
    var act_scores_midpoint: Float?
    var public_net_price_average: Int?
    var private_net_price_average: Int?
    var federal_loan_rate: Float?
    var student_size: Int?
    var admission_rate: Float?
}

struct SearchCollegeIDResponse: Decodable {
    var results: [SearchCollegeIDInformation]
}

struct SearchCollegeIDInformation: Decodable {
    var id : Int
}


