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
    
    var colleges: [College]?
    var selectedCollege: College?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addCollege(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showCollegeSearch", sender: self)
    }
    
    func createArray() -> [College] {
        
        var data: [College] = []
       
        data.append(College(name: "Agsdkjlfajskldfj", location: "New York, NY", url: ""))
        data.append(College(name: "College 2", location: "Philadelphia, PA", url: ""))
        data.append(College(name: "College 3", location: "college is good college is good college is good college is good college is good college is good college is good college is good college is good college is good college is good college is good college is good college is good college is good", url: ""))
        data.append(College(name: "College 4", location: "college is ok", url: ""))

        return data
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func viewDidLoad() {
        colleges = []
        super.viewDidLoad()
        colleges = createArray()
    
    
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        print(tableView.rowHeight)
        
        tableView.delegate = self
        tableView.dataSource = self
  
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    @IBAction func backToProfile(segue: UIStoryboardSegue){
    }

}
