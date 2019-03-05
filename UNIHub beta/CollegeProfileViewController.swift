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
    
    var colleges: [College] = [College(name: "1", description: "hi")]
    var selectedCollege: College?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addCollege(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showCollegeSearch", sender: self)
    }
    
    func createArray() -> [College] {
        
        var data: [College] = []
       
        data.append(College(name: "College 1", description: "college is good"))
        data.append(College(name: "College 2", description: "college is bad"))
        data.append(College(name: "College 3", description: "college is good college is good college is good college is good college is good college is good college is good college is good college is good college is good college is good college is good college is good college is good college is good"))
        data.append(College(name: "College 4", description: "college is ok"))

        return data
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        colleges = createArray()
    
    
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        
        tableView.delegate = self
        tableView.dataSource = self
  
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollegeCell") as! CollegeCell
        cell.collegeName.text = colleges[indexPath.row].name
        cell.collegeDescription.text = colleges[indexPath.row].description
 
        cell.collegeDescription.numberOfLines = 3
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colleges.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCollege = colleges[indexPath.row]
        performSegue(withIdentifier: "showCollegeInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCollegeInfo" {
            let collegeInfoViewController = segue.destination as! CollegeInfoViewController
            collegeInfoViewController.college = selectedCollege
        }
    }

}
