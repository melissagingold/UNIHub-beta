//
//  CollegeInfoViewController.swift
//  UNIHub beta
//
//  Created by Niklas Pant (student LM) on 2/26/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit

class CollegeInfoViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var collegeName: UILabel!
    @IBOutlet weak var collegeLocation: UILabel!
    @IBOutlet weak var statisticTableView: UITableView!
    
    var college: College?
    
    var collegeData = [String : [String : String]]()
    
    
    @IBAction func openWebsite(_ sender: UIButton) {
        //performSegue(withIdentifier: "openWebsite", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! CollegeInfoCell
        if indexPath.row == 0 {
            cell.name.text = Array(collegeData.keys)[indexPath.section]
            cell.statistic.text = ""
        }
        else {
            cell.name.text = Array(Array(collegeData.values)[indexPath.section].keys)[indexPath.row-1]
            cell.statistic.text = Array(Array(collegeData.values)[indexPath.section].values)[indexPath.row-1]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(Array(collegeData.values)[section].keys).count + 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Array(collegeData.keys).count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollegeData()
        collegeLocation.numberOfLines = 1
        
        collegeName.text = college!.name
        collegeLocation.text = college!.location
        
        statisticTableView.reloadData()
        
        
    }
    
    func setCollegeData(){
        if let averageSATScore = college?.averageSATScore {
            collegeData.updateValue(["Average SAT Score" : String(describing: averageSATScore)], forKey: "Admissions")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as? UIButton) != nil {
            let webViewController = segue.destination as! WebViewController
            webViewController.url = URL(string: college?.url ?? "")
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }

}
