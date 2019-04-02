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


class ApplicantProfileViewController: UITableViewController, AddActivity {
    
    var tableViewData = [cellData]()

    var activsA = ["Soccer", "9,10" , "Captain" , "MVP"]
    var activsB = Array(repeating: "", count: 4)
    var activsC = Array(repeating: "", count: 4)
    var activsD:[String?] = []
    var activsE:[String?] = []
    var activsF:[String?] = []
    var activsG:[String?] = []
    var activsH:[String?] = []
    var activsI:[String?] = []
    var activsJ:[String?] = []
    
    var diffActivs = [[String?]]()
    
    
    var newActivs = [Activity]()
    
    
    var activ1 = Activity(name: "", participation: "", position: "", honors: "")
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        diffActivs = [activsA, activsB, activsC, activsD, activsE, activsF, activsG, activsH, activsI, activsJ]
        
        newActivs = [activ1]
        
        
        tableViewData = [
            cellData(opened: false, title: "Activity #1: \(newActivs[0].name)", sectionData: ["Participation Grade Level: \(activ1.participation ) ","Position/Leadership: \(activsA[2] ?? "")","Honors/Acomplishments: \(activsA[3] ?? "")",]),
            cellData(opened: false, title: "Activity #2: \(activsB[0] ?? " ")", sectionData: ["Participation Grade Level: \(activsB[1])","Position/Leadership: \(activsB[2])","Honors/Acomplishments", ]),
            cellData(opened: false, title: "Activity #3", sectionData: ["Participation Grade Level","Position/Leadership","Honors/Acomplishments", ]),
            cellData(opened: false, title: "Activity #4", sectionData: ["Participation Grade Level","Position/Leadership","Honors/Acomplishments", ]),
            cellData(opened: false, title: "Activity #5", sectionData: ["Participation Grade Level","Position/Leadership","Honors/Acomplishments", ]),
            cellData(opened: false, title: "Activity #6", sectionData: ["Participation Grade Level","Position/Leadership","Honors/Acomplishments", ]),
            cellData(opened: false, title: "Activity #7", sectionData: ["Participation Grade Level","Position/Leadership","Honors/Acomplishments", ]),
            cellData(opened: false, title: "Activity #8", sectionData: ["Participation Grade Level","Position/Leadership","Honors/Acomplishments", ]),
            cellData(opened: false, title: "Activity #9", sectionData: ["Participation Grade Level","Position/Leadership","Honors/Acomplishments", ]),
            cellData(opened: false, title: "Activity #10", sectionData: ["Participation Grade Level","Position/Leadership","Honors/Acomplishments", ])
        ]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddActivityViewController
        vc.delegate = self
    }
    
    func addActivity(name: String, participation: String, position: String, honors: String){
        
        if newActivs[0].name == ""{
        activ1 = (Activity(name: name, participation: participation, position: position, honors: honors))
            print("hi")
        }
            tableView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
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
}






class Activity {
    var name = ""
    var participation = ""
    var position = ""
    var honors = ""
    
    init(name: String, participation: String, position: String, honors:String) {
        self.name = name
        self.participation = participation
        self.position = position
        self.honors = honors
    }
    
    func getName() -> String {
        return name
    }
}

