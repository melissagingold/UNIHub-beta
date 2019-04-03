////
////  ActivityViewController.swift
////  UNIHub beta
////
////  Created by Chloe Cowan (student LM) on 2/25/19.
////  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
////
//
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}


class ApplicantProfileViewController: UITableViewController, AddActivity{
    
    var tableViewData = [cellData]()
    var newActivs : [Activity]?
    var activ1 = Activity(name: "soccer", participation: "", position: "", honors: "")
    var activ2 = Activity(name: "tsa", participation: "", position: "", honors: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        //loadActivs()
        //newActivs = [activ1,activ2]
        tableView.reloadData()
        
    
//        tableViewData = [
//            cellData(opened: false, title: "Activity #1: \(newActivs?[0].name)", sectionData: ["Participation Grade Level: \(newActivs?[0].participation) ","Position/Leadership: \(newActivs?[0].position )","Honors/Acomplishments: \(newActivs?[0].honors )",]),
//            cellData(opened: false, title: "Activity #2: \(newActivs?[1].name)", sectionData: ["Participation Grade Level: \(newActivs?[1].participation)","Position/Leadership: \(newActivs?[1].position)","Honors/Acomplishments:", ])]//,
//            cellData(opened: false, title: "Activity #3:", sectionData: ["Participation Grade Level:","Position/Leadership:","Honors/Acomplishments:", ]),
//            cellData(opened: false, title: "Activity #4:", sectionData: ["Participation Grade Level:","Position/Leadership:","Honors/Acomplishments:", ]),
//            cellData(opened: false, title: "Activity #5:", sectionData: ["Participation Grade Level:","Position/Leadership:","Honors/Acomplishments:"]),
//            cellData(opened: false, title: "Activity #6:", sectionData: ["Participation Grade Level:","Position/Leadership:","Honors/Acomplishments:"]),
//            cellData(opened: false, title: "Activity #7", sectionData: ["Participation Grade Level","Position/Leadership","Honors/Acomplishments", ]),
//            cellData(opened: false, title: "Activity #8", sectionData: ["Participation Grade Level","Position/Leadership","Honors/Acomplishments", ]),
//            cellData(opened: false, title: "Activity #9", sectionData: ["Participation Grade Level","Position/Leadership","Honors/Acomplishments", ]),
//            cellData(opened: false, title: "Activity #10", sectionData: ["Participation Grade Level","Position/Leadership","Honors/Acomplishments", ])
//        ]
    }
    
    
    //conecting the view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddActivityViewController
        vc.delegate = self
    }
    func addActivity(name: String, participation: String, position: String, honors: String){
    
//        for i in 0...10{
//            if newActivs[i].name == ""{
                newActivs?.append(Activity(name: name, participation: participation, position: position, honors: honors))
                print("hi")
           // }
      //  }
            tableView.reloadData()
    }
    func loadActivs(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("user/\(uid)/Activities")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? [String : Bool] {
                for str in (data.keys) {
                    let activ = Activity(name: str, participation: str, position: str, honors: str)
                    self.newActivs?.append(activ)
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
        
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            
            return cell
        }
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{return UITableViewCell()}
            
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row-1]
            
            return cell
        }
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

