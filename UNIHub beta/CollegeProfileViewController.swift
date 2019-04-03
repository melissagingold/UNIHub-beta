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
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        loadColleges()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 88
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveColleges()
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
    
    func saveColleges(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("user/\(uid)/Colleges")
        var collegeData = [[String : String]]()
        for college in colleges ?? [] {
            collegeData.append(["\(college.id)" : college.userNotes])
        }
        ref.setValue(collegeData)
    }
    
    func loadColleges(){
        colleges = []
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("user/\(uid)/Colleges")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let result = snapshot.value as? [[String : String]]{
                for college in result {
                    self.addCollegeInfo(id: Int(Array(college.keys)[0])!, notes: Array(college.values)[0])
                }
            }
        }
    }
    
    func addCollegeInfo(id: Int, notes: String){
        College.getData(id: id, notes: notes) { (college) in
            self.colleges?.append(college)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func backToProfile(segue: UIStoryboardSegue){
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            colleges?.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }

}
