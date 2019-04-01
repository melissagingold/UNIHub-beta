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
    
    static let apiKey = "YHpGhGV1Yl8GAo0XOLblgqKu4vuffmQT6JyakopO"
    
    var id : Int
    var name : String
    var location : String
    var url : String
    var averageSATScore : Float?
    var averageNetPrice : Int?
    
    var userNotes : String
    
    init(id: Int, name: String, location: String, url : String, averageSATScore : Float?, averageNetPrice: Int?){
        self.id = id
        self.name = name
        self.location = location
        self.url = url
        self.averageSATScore = averageSATScore
        self.averageNetPrice = averageNetPrice
        userNotes = ""
    }
    
    static func getData(id: Int, notes: String, complete: @escaping (College) -> () ){
        let urlString = "https://api.data.gov/ed/collegescorecard/v1/schools.json?id=\(id)&_fields=id,school.name,school.city,school.state,school.school_url,latest.admissions.sat_scores.average.overall,latest.cost.avg_net_price.public,latest.cost.avg_net_price.private&api_key=" + apiKey
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, request, error) in
            guard var data = data else {return}
            data = (String(data: data, encoding: String.Encoding.utf8)!).replacingOccurrences(of: "school.", with: "").data(using: String.Encoding.utf8)!
            data = (String(data: data, encoding: String.Encoding.utf8)!).replacingOccurrences(of: "latest.admissions.sat_scores.average.overall", with: "sat_scores_average").data(using: String.Encoding.utf8)!
            data = (String(data: data, encoding: String.Encoding.utf8)!).replacingOccurrences(of: "latest.cost.avg_net_price.public", with: "public_net_price_average").data(using: String.Encoding.utf8)!
            data = (String(data: data, encoding: String.Encoding.utf8)!).replacingOccurrences(of: "latest.cost.avg_net_price.private", with: "private_net_price_average").data(using: String.Encoding.utf8)!
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
                        averageNetPrice: price
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
