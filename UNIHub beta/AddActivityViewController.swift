//
//  AddActivityViewController.swift
//  UNIHub beta
//
//  Created by Melissa Gingold (student LM) on 3/21/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit
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
    
    var delegate: AddActivity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
            //delegate?.addActivity(name: activName.text ?? "", participation: activPartic.text ?? "", position: activPosit.text ?? "", honors: activHon.text ?? "")
        performSegue(withIdentifier: "backToActivities", sender: self)
            
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ApplicantProfileViewController
        vc.tableViewData.append(cellData(opened: false, title: "Activity #\(vc.tableViewData.count+1):" + activName.text!,
                                         sectionData: ["Participation Grade Level:" + activPartic.text!,"Position/Leadership:" + activPosit.text!,"Honors/Acomplishments:" + activHon.text!]))
        vc.tableView.reloadData()
    }
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


