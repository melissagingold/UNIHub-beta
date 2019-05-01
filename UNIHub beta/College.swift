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
    // api key for information from database
    static let apiKey = "YHpGhGV1Yl8GAo0XOLblgqKu4vuffmQT6JyakopO"
    
    // variables
    var id: Int
    var name: String
    var location: String
    var url: String
    var averageSATScore: Float?
    var midpointACTScore: Float?
    var averageNetPrice: Int?
    var federalLoanRate: Float?
    var studentSize: Int?
    var admissionRate: Float?
    
    var userNotes : String
    
    // initializing all variables parsed from database
    init(id: Int, name: String, location: String, url : String, averageSATScore : Float?, midpointACTScore: Float? ,averageNetPrice: Int?, federalLoanRate: Float?, studentSize: Int?, admissionRate: Float?){
        self.id = id
        self.name = name
        self.location = location
        self.url = url
        self.averageSATScore = averageSATScore
        self.midpointACTScore = midpointACTScore
        self.averageNetPrice = averageNetPrice
        self.federalLoanRate = federalLoanRate
        self.studentSize = studentSize
        self.admissionRate = admissionRate
        userNotes = ""
    }
    
    static func getData(id: Int, notes: String, complete: @escaping (College) -> () ){
        let urlString = "https://api.data.gov/ed/collegescorecard/v1/schools.json?id=\(id)&_fields=id,school.name,school.city,school.state,school.school_url,latest.admissions.sat_scores.average.overall,latest.admissions.act_scores.midpoint.cumulative,latest.cost.avg_net_price.public,latest.cost.avg_net_price.private,latest.aid.federal_loan_rate,latest.student.size,latest.admissions.admission_rate.overall&api_key=" + apiKey
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, request, error) in
            guard var data = data else {return}
            data = (String(data: data, encoding: String.Encoding.utf8)!).replacingOccurrences(of: "school.", with: "").data(using: String.Encoding.utf8)!
            data = (String(data: data, encoding: String.Encoding.utf8)!).replacingOccurrences(of: "latest.admissions.sat_scores.average.overall", with: "sat_scores_average").data(using: String.Encoding.utf8)!
            data = (String(data: data, encoding: String.Encoding.utf8)!).replacingOccurrences(of: "latest.cost.avg_net_price.public", with: "public_net_price_average").data(using: String.Encoding.utf8)!
            data = (String(data: data, encoding: String.Encoding.utf8)!).replacingOccurrences(of: "latest.cost.avg_net_price.private", with: "private_net_price_average").data(using: String.Encoding.utf8)!
            data = (String(data: data, encoding: String.Encoding.utf8)!).replacingOccurrences(of: "latest.aid.federal_loan_rate", with: "federal_loan_rate").data(using: String.Encoding.utf8)!
            data = (String(data: data, encoding: String.Encoding.utf8)!).replacingOccurrences(of: "latest.admissions.act_scores.midpoint.cumulative", with: "act_scores_midpoint").data(using: String.Encoding.utf8)!
            data = (String(data: data, encoding: String.Encoding.utf8)!).replacingOccurrences(of: "latest.student.size", with: "student_size").data(using: String.Encoding.utf8)!
            data = (String(data: data, encoding: String.Encoding.utf8)!).replacingOccurrences(of: "latest.admissions.admission_rate.overall", with: "admission_rate").data(using: String.Encoding.utf8)!
            do {
                let searchCollegeResponse : SearchCollegeResponse? = try JSONDecoder().decode(SearchCollegeResponse.self, from: data)
                DispatchQueue.main.async {
                    let result = searchCollegeResponse?.results[0]
                    var price: Int? {
                        get {
                            if result?.public_net_price_average != nil {
                                return result?.public_net_price_average
                            }
                            else {
                                return result?.private_net_price_average
                            }
                        }
                    }
                    let college = College(
                        id: result?.id ?? 0,
                        name: result?.name ?? "N/A",
                        location: (result?.city ?? "") + ", " + (result?.state ?? ""),
                        url: "https://" + (result?.school_url ?? ""),
                        averageSATScore: (result?.sat_scores_average),
                        midpointACTScore: result?.act_scores_midpoint,
                        averageNetPrice: price,
                        federalLoanRate: result?.federal_loan_rate,
                        studentSize: result?.student_size,
                        admissionRate: result?.admission_rate
                    )
                    college.userNotes = notes
                    complete(college)
                }
            } catch let jsonErr {
                print(jsonErr)
            }
        }.resume()
    }
    
}
