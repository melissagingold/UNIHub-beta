////
////  ActivityViewController.swift
////  UNIHub beta
////
////  Created by Chloe Cowan (student LM) on 2/25/19.
////  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
////
//
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}


class ApplicantProfileViewController: UITableViewController, AddActivity{
    
    //variable declarations
    var tableViewData = [cellData]()
    var newActivs : [Activity]?
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        newActivs = []
        loadActivs()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveActivs()
    }
    
    //conecting the view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddActivityViewController
        vc.delegate = self
    }
    func addActivity(name: String, participation: String, position: String, honors: String){
                newActivs?.append(Activity(name: name, participation: participation, position: position, honors: honors))
            tableView.reloadData()
    }
    
    //firebase
    func saveActivs() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("user/\(uid)/Activities")
        var activities = [[String : [String]]]()
        for activity in tableViewData {
            activities.append([activity.title : [activity.sectionData[0], activity.sectionData[1], activity.sectionData[2]]])
        }
        ref.setValue(activities)
    }
    
    
    func loadActivs(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("user/\(uid)/Activities")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? [[String: [String]]] {
                for activity in data {
                    var details = [String]()
                    for text in Array(activity.values)[0]{
                        details.append(text)
                    }
                    let addActivity = cellData(opened: false, title: Array(activity.keys)[0], sectionData: details)
                    
                    self.tableViewData.append(addActivity)
                }
            }
            self.tableView.reloadData()
        }
    }
    
    //table view functionality
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true{
           return tableViewData[section].sectionData.count+1
        }
        else{
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
        if indexPath.row == 0{
            cell.textLabel?.text = "Activity #\(indexPath.section+1): " + tableViewData[indexPath.section].title
        }
        else if indexPath.row == 1{
            cell.textLabel?.text = "Participation Grade Level: " + tableViewData[indexPath.section].sectionData[indexPath.row-1]

        }
        else if indexPath.row == 2{
            cell.textLabel?.text = "Position/Leadership: " + tableViewData[indexPath.section].sectionData[indexPath.row-1]
            
        }
        else if indexPath.row == 3{
            cell.textLabel?.text = "Honors/Acomplishments: " + tableViewData[indexPath.section].sectionData[indexPath.row-1]
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if tableViewData[indexPath.section].opened == true{
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
            else{
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
    }
    
    @IBAction func backToActivities(segue: UIStoryboardSegue){
    }
}

class Activity {
    var name = ""
    var participation = ""
    var position = ""
    var honors = ""
    
    init(name: String?, participation: String?, position: String?, honors:String?) {
        self.name = name ?? ""
        self.participation = participation ?? ""
        self.position = position ?? ""
        self.honors = honors ?? ""

    }
    
    func getName() -> String {
        return name
    }
}

