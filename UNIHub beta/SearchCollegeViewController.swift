//
//  SearchCollegeViewController.swift
//  UNIHub beta
//
//  Created by Niklas Pant (student LM) on 3/4/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit

class SearchCollegeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var apiKey = "YHpGhGV1Yl8GAo0XOLblgqKu4vuffmQT6JyakopO"
    
    var searchResults : [College] = []
    
    var searchResult : College?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCollegeCell", for: indexPath) as! SearchCollegeCell
        cell.collegeName.text = searchResults[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchResult = searchResults[indexPath.row]
        performSegue(withIdentifier: "backToProfile", sender: self)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
        searchCollege(query: searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         performSegue(withIdentifier: "backToProfile", sender: self)
    }
    
    
    func searchCollege(query: String){
        let urlString = "https://api.data.gov/ed/collegescorecard/v1/schools.json?school.name=" + query.replacingOccurrences(of: " ", with: "%20") + "&_fields=id,school.name,school.city,school.state,school_url&api_key=" + apiKey
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, request, error) in
            guard let data = (String(data: data!, encoding: String.Encoding.utf8)!).replacingOccurrences(of: "school.", with: "school").data(using: String.Encoding.utf8) else {return}
            do {
                let searchCollegeResponse : SearchCollegeResponse? = try JSONDecoder().decode(SearchCollegeResponse.self, from: data)
                DispatchQueue.main.async {
                    let results = searchCollegeResponse?.results.count ?? 0
                    self.searchResults = []
                    for i in 0..<results {
                        let college = College(name: searchCollegeResponse?.results[i].schoolname ?? "N/A",
                            location: (searchCollegeResponse?.results[i].schoolcity ?? "") + ", " +
                            (searchCollegeResponse?.results[i].schoolstate ?? ""),
                            url: searchCollegeResponse?.results[i].schoolschool_url ?? "")
                        self.searchResults.append(college)
                        self.searchTableView.reloadData()
                    }
                }
            } catch let jsonErr {
                print(jsonErr)
            }
        }.resume()
    }
    
//    func getCollegeInfo(id: Int){
//        let urlString = "https://api.data.gov/ed/collegescorecard/v1/schools.json?id=" + "\(id)" + "&api_key=" + apiKey
//        guard let url = URL(string: urlString) else {return}
//        URLSession.shared.dataTask(with: url) { (data, request, error) in
//            guard let data = data else {return}
//            print(data)
//            do{
//                let collegeResponse : CollegeResponse? = try JSONDecoder().decode(CollegeResponse.self, from: data)
//                DispatchQueue.main.async {
//                    let results = collegeResponse?.results.count ?? 0
//                    self.searchResults = []
//                    for i in 0..<results {
//                        self.searchResults.append(collegeResponse?.results[i].year ?? 0)
//                    }
//                }
//            } catch let jsonErr {
//                print(jsonErr)
//            }
//        }.resume()
//    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let result = searchResult {
            let vc = segue.destination as! CollegeProfileViewController
            vc.colleges?.append(result)
        }
    }
    
    
}
