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

// protocol that can be called in the main activity class as well (ApplicantProfileViewController)
protocol AddActivity {
    func addActivity(name:String, participation:String, position:String, honors:String)
}

class AddActivityViewController: UIViewController, UITextFieldDelegate{

    // variables
    @IBOutlet weak var activName: UITextField!
    @IBOutlet weak var activPartic: UITextField!
    @IBOutlet weak var activPosit: UITextField!
    @IBOutlet weak var activHon: UITextField!
    var refActivity = DatabaseReference()
    
    // delegate for the addActivity function
    var delegate: AddActivity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refActivity = DatabaseReference().database.reference().child("activities")
    }
    
    // goes back to the activity list
    @IBAction func backButton(_ sender: UIButton) {
       
        performSegue(withIdentifier: "backToActivities", sender: self)    
    }
    
    
    // to prevent nil error - will add / save to firebase only if the activity has text entered
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ApplicantProfileViewController

        if activName.text! != "" {
            vc.tableViewData.append(cellData(opened: false, title: activName.text!,
                                         sectionData: [activPartic.text!,activPosit.text!,activHon.text!]))
        }
        

        vc.tableView.reloadData()
    }
    
}



