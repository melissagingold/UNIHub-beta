//
//  CollegeInfoViewController.swift
//  UNIHub beta
//
//  Created by Niklas Pant (student LM) on 2/26/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit

class CollegeInfoViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var collegeName: UILabel!
    @IBOutlet weak var collegeLocation: UILabel!
    @IBOutlet weak var statisticTableView: UITableView!
    @IBAction func goToWebsite(_ sender: UIButton!) {
        performSegue(withIdentifier: "openWebsite", sender: nil)
    }
    
    var college: College?
    
    var collegeData = [(section: String, items: [(name: String, statistic: String)], opened: Bool)]()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! CollegeInfoCell
        if indexPath.row == 0 {
            cell.name.text = collegeData[indexPath.section].section
            cell.statistic.text = ""
            cell.dropDown.isHidden = false
            if collegeData[indexPath.section].opened {
                cell.dropDown.image = #imageLiteral(resourceName: "dropDown")
            }
            else {
                cell.dropDown.image = UIImage(cgImage: #imageLiteral(resourceName: "dropDown").cgImage!, scale: 1, orientation: .downMirrored)
            }
        }
        else if indexPath.row != 0 && collegeData[indexPath.section].opened {
            cell.dropDown.isHidden = true
            cell.name.text = collegeData[indexPath.section].items[indexPath.row-1].name
            cell.statistic.text = collegeData[indexPath.section].items[indexPath.row-1].statistic
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var sections = 1
        if collegeData[section].opened {
            sections = collegeData[section].items.count + 1
        }
        return sections
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return collegeData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let statName = collegeData[indexPath.section].items[indexPath.row-1].name
        if indexPath.row == 0 {
            collegeData[indexPath.section].opened = !collegeData[indexPath.section].opened
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                let rotation = CGFloat.pi
                (tableView.cellForRow(at: indexPath) as! CollegeInfoCell).dropDown.transform = CGAffineTransform(rotationAngle: rotation)
            }, completion: { (comp) in
                (tableView.cellForRow(at: indexPath) as! CollegeInfoCell).dropDown.transform = CGAffineTransform.identity
                tableView.reloadSections(IndexSet.init(integer: indexPath.section), with: .none)
            })
        }
        else if statName == "Admission Rate" {
            createAlert(title: statName, message: "Percentage of applicants admitted into the college.")
        }
        else if statName == "Average SAT Score" {
            createAlert(title: statName, message: "Average SAT score of students attending the college.")
        }
        else if statName == "Midpoint ACT Score" {
            createAlert(title: statName, message: "Midpoint ACT score of students attending the college.")
        }
        else if statName == "Average Net Price" {
            createAlert(title: statName, message: "Annual cost of attendence at the college consisting of tuition fees and living expenses minus average aid given to student.")
        }
        else if statName == "Federal Loan Rate" {
            createAlert(title: statName, message: "Percentage of students attending the college that receive a federal loan.")
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        college?.userNotes = textView.text
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notes.layer.cornerRadius = 15
        notes.clipsToBounds = true
        
        setCollegeData()
        collegeLocation.numberOfLines = 1
        
        notes.text = college?.userNotes
        
        collegeName.text = college?.name
        collegeLocation.text = college?.location
        
        statisticTableView.reloadData()
        for cell in statisticTableView.visibleCells {
            (cell as! CollegeInfoCell).dropDown.image = #imageLiteral(resourceName: "dropDown")
        }
        
        
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
            collegeData.append((section, itemsInSection, true))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openWebsite" {//(sender as? UIButton) != nil {
            let webViewController = segue.destination as! WebViewController
            webViewController.url = URL(string: college?.url ?? "")
        }
    }

    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
