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
        if activName.text! == "" {
            createAlert(title: "WARNING", message: "No activity name has been entered!")
        }
        else {
            performSegue(withIdentifier: "backToActivities", sender: self)
        }
    }
    
    @IBAction func backButton(_ sender: UIButton) {
       
        performSegue(withIdentifier: "backToActivities", sender: self)    
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ApplicantProfileViewController

        if activName.text! != "" {
            vc.tableViewData.append(cellData(opened: false, title: activName.text!,
                                         sectionData: [activPartic.text!,activPosit.text!,activHon.text!]))
        }
        

        vc.tableView.reloadData()
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Enter Task", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}



