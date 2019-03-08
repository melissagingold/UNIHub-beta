////
////  ActivityViewController.swift
////  UNIHub beta
////
////  Created by Chloe Cowan (student LM) on 2/25/19.
////  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
////
//
import UIKit
//

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
    }
class ApplicantProfileViewController: UITableViewController{
    
    var tableViewData = [cellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewData = [cellData(opened: false, title: "Title1", sectionData: ["Cell1","Cell2"])]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //change this
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //change this & the cell's identifier in storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
        return cell
    }


//
//    @IBOutlet weak var testPicker: UIPickerView!
//    let test = ["SAT:", "ACT:"]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        testPicker.selectRow(testPicker.numberOfRows(inComponent: 0)/2, inComponent: 0, animated: true)
//        
//        // Do any additional setup after loading the view.
//        GPAText.delegate = self
//        scoreText.delegate = self
//        
//        GPAText.becomeFirstResponder()
//        
//        //        activitiesTableView.delegate = self
//        //        activitiesTableView.dataSource = self as? UITableViewDataSource
//    }
//    func pickerView(testPicker : UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let defaults = UserDefaults.standard
//        defaults.set(row, forKey: "row")
//        defaults.synchronize()
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//       return test.count
//    }
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return "\(test[row])"
//    }
//
//    //textFields
//    @IBOutlet weak var GPAText: UITextField!
//    @IBOutlet weak var scoreText: UITextField!
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if GPAText.isFirstResponder{
//            scoreText.becomeFirstResponder()
//        }
//        else{
//            self.view.endEditing(true)
//            scoreText.resignFirstResponder()
//        }
//        return true
//    }
//
//
//    //adding AP Tests
//    @IBOutlet weak var addAPTestText: UITextField!
//    @IBOutlet weak var addAPTestScore: UITextField!
//    @IBOutlet weak var APTestList2: UITextView!
//
//    @IBAction func addAPTest(_ sender: UIButton) {
//        if let text = addAPTestText.text{
//            if text == ""{
//                return
//            }
//        APTestList2.text?.append("\(text)")
//            addAPTestText.text = ""
//        addAPTestScore.resignFirstResponder()
//        }
//
//        if let text2 = addAPTestScore.text{
//            if text2 == ""{
//                return
//            }
//            APTestList2.text?.append(":\(text2)\n")
//            addAPTestScore.text = ""
//            addAPTestText.resignFirstResponder()
//        }
//
//    }
//
//    //adding SAT2 Tests
//    @IBOutlet weak var addSAT2Text: UITextField!
//    @IBOutlet weak var SAT2List: UITextView!
//
//    @IBAction func addSAT2Test(_ sender: UIButton) {
//        if let text = addSAT2Text.text{
//            if text == ""{
//                return
//            }
//            SAT2List.text?.append("\(text)\n")
//            addSAT2Text.text = ""
//        addSAT2Text.resignFirstResponder()
//        }
//    }
//
//
//
//
//
//
//
//
//
//
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
////
////        cell.textLabel?.numberOfLines = 4
////        let row = indexPath.row
////
////        return cell
////
////    }
////    //activities
////    @IBOutlet weak var activitiesTableView: UITableView!
////    let sections = ["Years Involved:", "Position/s:", "Awards:"]
//
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return self.sections[section].count
////    }
//
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! UITableViewCell
////        cell.textLabel?.numberOfLines = 4
////        let row = indexPath.row
////
////        return cell
////    }
//
////    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
////        let cell : ActivityTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ActivityTableViewCell") as! ActivityTableViewCell
////
////
////        return cell
////    }
////
////
////    func getActivities(_ completion: @escaping((_ activity:String?)->())){
////        guard let uid = Auth.auth().currentUser?.uid else{return}
////
////        let databaseRef = Database.database().reference().child("users/\(uid)")
////        databaseRef.observeSingleEvent(of: .value, with: {snapshot in
////            let postDict = snapshot.value as? [String: AnyObject] ?? [:]
////
////            if let activityTitle = postDict["Activity Title"]{
////                completion(activityTitle as? String)
////            }
////        }){ (error) in
////            print(error.localizedDescription)
////        }
////
////
////    }
//
////    @IBAction func saveButton(_ sender: UIButton) {
////        getActivities(){ url in
////            let storage = Storage.storage()
////            guard let activity = url else {return}
////            let ref = storage.reference(forURL:activity)
////
////            ref.getData(maxSize: 1*1024*1024){ data, error in
////                if error == nil && data != nil{
////                    self.reloadInputViews()
////                }
////                else{
////                    print(error?.localizedDescription)
////                }
////            }
////        }
////    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
}
