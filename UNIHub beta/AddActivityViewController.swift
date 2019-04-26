//
//  AddActivityViewController.swift
//  UNIHub beta
//
//  Created by Melissa Gingold (student LM) on 3/21/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

protocol AddActivity {
    func addActivity(name:String, participation:String, position:String, honors:String)
}


class AddActivityViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var activName: UITextField!
    @IBOutlet weak var activPartic: UITextField!
    @IBOutlet weak var activPosit: UITextField!
    @IBOutlet weak var activHon: UITextField!
    var refActivity = DatabaseReference()
    
    
    var delegate: AddActivity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refActivity = DatabaseReference().database.reference().child("activities")
    }
    
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "backToActivities", sender: self)
        }
    
    @IBAction func backButton(_ sender: UIButton) {
       
        performSegue(withIdentifier: "backToActivities", sender: self)    
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ApplicantProfileViewController
        
        if activHon.text != nil{
        vc.tableViewData.append(cellData(opened: false, title: "Activity #\(vc.tableViewData.count+1):" + activName.text!,
                                         sectionData: ["Participation Grade Level:" + activPartic.text!,"Position/Leadership:" + activPosit.text!,"Honors/Acomplishments:" + activHon.text!]))
        }
        

        vc.tableView.reloadData()
        addToFB()
    }
    
    func addToFB(){
        let key = refActivity.childByAutoId().key
        
        let activity = ["id": key,"activityName":activName.text,"activityParticipation":activPartic.text,"activityPosition":activPosit.text,"activityHonors":activHon.text
        ]
        
        refActivity.child(key ?? "").setValue(activity)
        
    }
    
}



