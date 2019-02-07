//
//  ApplicantProfileViewController.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 2/1/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class ApplicantProfileViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
    
        testPicker.selectRow(testPicker.numberOfRows(inComponent: 0)/2, inComponent: 0, animated: true)
    
        // Do any additional setup after loading the view.
    }
    
    
    
    //pciker view to select ACT or SAT
    @IBOutlet weak var testPicker: UIPickerView!
    let test = ["SAT:", "ACT:"]
    
    func pickerView(testPicker : UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: "row")
        defaults.synchronize()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return test.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(test[row])"
    }
    
    
    
    
    
    //textFields
    @IBOutlet weak var GPAText: UITextField!
    @IBOutlet weak var scoreText: UITextField!
    
    
    
    
    
    @IBOutlet weak var activitiesTableView: UITableView!
    let sections = ["Years Involved:", "Position/s:", "Awards:"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! UITableViewCell
        
        cell.textLabel?.numberOfLines = 4
        let row = indexPath.row
        
        // set cell's title
        return cell
    }
    
    func getActivities(_ completion: @escaping((_ activity:String?)->())){
        guard let uid = Auth.auth().currentUser?.uid else{return}
        
        let databaseRef = Database.database().reference().child("users/\(uid)")
        databaseRef.observeSingleEvent(of: .value, with: {snapshot in
            let postDict = snapshot.value as? [String: AnyObject] ?? [:]
            
            if let activityTitle = postDict["Activity Title"]{
                completion(activityTitle as? String)
            }
        }){ (error) in
            print(error.localizedDescription)
        }
    
        
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        getActivities(){ url in
            let storage = Storage.storage()
            guard let activity = url else {return}
            let ref = storage.reference(forURL:activity)
            
            ref.getData(maxSize: 1*1024*1024){ data, error in
                if error == nil && data != nil{
                    self.reloadInputViews()
                }
                else{
                    print(error?.localizedDescription)
                }
            }
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

}

