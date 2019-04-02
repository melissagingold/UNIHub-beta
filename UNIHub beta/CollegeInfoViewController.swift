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
    
    var collegeData = [(section: String, items: [(name: String, statistic: String)] )]()
    
    
    @IBAction func openWebsite(_ sender: UIButton) {
        //performSegue(withIdentifier: "openWebsite", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! CollegeInfoCell
        if indexPath.row == 0 {
            cell.name.text = collegeData[indexPath.section].section
            //cell.name.text = Array(collegeData[indexPath.section].keys)[0]
            //cell.name.text = Array(collegeData.keys)[indexPath.section]
            cell.statistic.text = ""
        }
        else {
            cell.name.text = collegeData[indexPath.section].items[indexPath.row-1].name
            cell.statistic.text = collegeData[indexPath.section].items[indexPath.row-1].statistic
            //cell.name.text = Array(Array(collegeData[indexPath.section].values)[0].keys)[indexPath.row-1]
            //cell.statistic.text = Array(Array(collegeData[indexPath.section].values)[0].values)[indexPath.row-1]
            //cell.name.text = Array(Array(collegeData.values)[indexPath.section].keys)[indexPath.row-1]
            //cell.statistic.text = Array(Array(collegeData.values)[indexPath.section].values)[indexPath.row-1]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collegeData[section].items.count + 1
        //return Array(Array(collegeData.values)[section].keys).count + 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return collegeData.count
        //return Array(collegeData.keys).count
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
        collegeData = []
        var allData = [(section: String, name: String, statistic: String)]()
        if let admissionRate = college?.admissionRate {
            allData.append(("Admissions","Admission Rate",String(describing: admissionRate*100)+"%"))
        }
        if let averageSATScore = college?.averageSATScore {
            allData.append(("Admissions","Average SAT Score",String(describing: Int(averageSATScore))))
        }
        if let midpointACTScore = college?.midpointACTScore {
            allData.append(("Admissions","Midpoint ACT Score",String(describing: Int(midpointACTScore))))
        }
        if let averageNetPrice = college?.averageNetPrice {
            allData.append(("Costs","Average Net Price","$"+String(describing: averageNetPrice)))
        }
        if let federalLoanRate = college?.federalLoanRate {
            allData.append(("Aid","Federal Loan Rate",String(describing: federalLoanRate*100)+"%"))
        }
        
        var sections = [String]()
        for item in allData{
            if !sections.contains(item.section){
                sections.append(item.section)
            }
        }
        for section in sections {
            var itemsInSection = [(name: String, statistic: String)]()
            for item in allData {
                if item.section == section {
                    itemsInSection.append((item.name, item.statistic))
                }
            }
            collegeData.append((section, itemsInSection))
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
