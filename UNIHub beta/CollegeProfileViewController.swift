//
//  CollegeProfileViewController.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 2/1/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class CollegeProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let apiKey = "YHpGhGV1Yl8GAo0XOLblgqKu4vuffmQT6JyakopO"
    
    var colleges: [College]?
    var selectedCollege: College?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addCollege(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showCollegeSearch", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func viewDidLoad() {
        loadColleges()
        colleges = []
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveColleges(colleges: colleges!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 88
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollegeCell") as! CollegeCell
        cell.collegeName.text = colleges?[indexPath.row].name
        cell.collegeLocation.text = colleges?[indexPath.row].location
 
        cell.collegeLocation.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colleges?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCollege = colleges?[indexPath.row]
        performSegue(withIdentifier: "showCollegeInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCollegeInfo" {
            let collegeInfoViewController = segue.destination as! CollegeInfoViewController
            collegeInfoViewController.college = selectedCollege
        }
    }
    
    func saveColleges(colleges: [College]){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("user/\(uid)/Colleges")
        var collegeDictionary : [String : String] = [:]
        for college in colleges {
            collegeDictionary.updateValue(college.name, forKey: "\(college.id)")
        }
        ref.setValue(collegeDictionary)
    }
    
    func loadColleges(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("user/\(uid)/Colleges")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            let data = snapshot.value as! [String : String]
            for str in data.keys {
                self.addCollegeInfo(id: Int(str)!)
            }
        }
    }
    
    func addCollegeInfo(id: Int){
        let urlString = "https://api.data.gov/ed/collegescorecard/v1/schools.json?id=\(id)&_fields=id,school.name,school.city,school.state,school.school_url,latest.admissions.sat_scores.average.overall&api_key=" + apiKey
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, request, error) in
            guard var data = data else {return}
            data = (String(data: data, encoding: String.Encoding.utf8)!).replacingOccurrences(of: "school.", with: "").data(using: String.Encoding.utf8)!
            data = (String(data: data, encoding: String.Encoding.utf8)!).replacingOccurrences(of: "latest.admissions.sat_scores.average.overall", with: "sat_scores_average").data(using: String.Encoding.utf8)!
            do {
                let searchCollegeResponse : SearchCollegeResponse? = try JSONDecoder().decode(SearchCollegeResponse.self, from: data)
                DispatchQueue.main.async {
                    let result = searchCollegeResponse?.results[0]
                    let college = College(name: result?.name ?? "N/A",
                                        location: (result?.city ?? "") + ", " + (result?.state ?? ""),
                                        url: "https://" + (result?.school_url ?? ""),
                                        averageSATScore: (result?.sat_scores_average ?? 0),
                                        id: result?.id ?? 0)
                    self.colleges?.append(college)
                    self.tableView.reloadData()
                }
            } catch let jsonErr {
                print(jsonErr)
            }
        }.resume()
    }
    
    @IBAction func backToProfile(segue: UIStoryboardSegue){
    }

}
