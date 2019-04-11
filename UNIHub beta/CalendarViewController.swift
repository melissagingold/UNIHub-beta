//
//  CalendarViewController.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 2/1/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate, AddCalendarTask{
    
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var myViewController: UICollectionView!
    
    @IBOutlet weak var tasksTable: UITableView!
    
    var myString = String()
    var yo = 1
    var currentMonth = 1
    var currentYear = 2019
    var array: [String] = []
    var selectedDay = -1
    var months : [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var length : [Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    var tasks : [String: [String]] = [:]
    var space = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCalendar()
        tasksTable.reloadData()
        tasksTable.isHidden = true
        print("calendar")
        print("test")

    }
    @IBAction func downMonth(_ sender: UIButton) {
        selectedDay = -1
        if currentMonth == 0{
            currentMonth = 11
            currentYear -= 1
        }
        else{
            currentMonth -= 1
        }
        updateCalendar()
        
    }
    @IBAction func upMonth(_ sender: UIButton) {
        selectedDay = -1
        if currentMonth == 11{
            currentMonth = 0
            currentYear += 1
        }
        else{
            currentMonth += 1
        }
        print(tasks)
        updateCalendar()
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "goToTask" {
            if selectedDay == -1 {
                return false
            }
        }
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var taskController = segue.destination as! AddCalendarTaskViewController
        taskController.delegate = self
        taskController.key = String(currentMonth) + " " +  String(selectedDay) + " " +  String(currentYear)
    }
    func addCalendarTask(id: String, task: String) {
        var currentDay : [String]
        if(tasks.keys.contains(id)){
            currentDay = tasks[id]!
        }
        else{
            currentDay =  [String]()
        }
        currentDay.append(task)
        tasks.updateValue(currentDay, forKey: id)
        selectedDay = -1
        myViewController.reloadData()
        tasksTable.reloadData()
    }
    
    func updateCalendar(){
        array = []
        for i in 1...length[currentMonth]{
            array.append(String(i))
        }
        monthLabel.text = months[currentMonth] + " " + String(currentYear)
        myViewController.reloadData()
        tasksTable.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/7-7, height: collectionViewWidth/7-7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDay = indexPath.row
        if tasks.keys.contains(String(currentMonth) + " " +  String(selectedDay) + " " +  String(currentYear)){
            tasksTable.isHidden = false
        }
        else{
            tasksTable.isHidden = true
        }
        tasksTable.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CalendarViewCell
        
        cell.label.text = array[indexPath.row]
        if tasks.keys.contains(String(currentMonth) + " " +  String(indexPath.row) + " " +  String(currentYear)) {
            
            cell.dot.image = UIImage(named: "dot")
            
        }
        else{
            cell.dot.image = UIImage()
        }
        
        let backgroundColorView = UIView()
        backgroundColorView.backgroundColor = UIColor.red
        cell.selectedBackgroundView = backgroundColorView
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        print(tasks)
        if tasks.keys.contains(String(currentMonth) + " " +  String(selectedDay) + " " +  String(currentYear)) && tasks[String(currentMonth) + " " +  String(selectedDay) + " " +  String(currentYear)]!.count > indexPath.row{
            cell.textLabel?.text = String(tasks[String(currentMonth) + " " +  String(selectedDay) + " " +  String(currentYear)]![indexPath.row])
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            if tasks.keys.contains(String(currentMonth) + " " +  String(selectedDay) + " " +  String(currentYear)) && tasks[String(currentMonth) + " " +  String(selectedDay) + " " +  String(currentYear)]!.count > indexPath.row {
                tasks[String(currentMonth) + " " +  String(selectedDay) + " " +  String(currentYear)]?.remove(at: indexPath.row)
                if tasks[String(currentMonth) + " " +  String(selectedDay) + " " +  String(currentYear)]?.count == 0{
                    tasks.removeValue(forKey: String(currentMonth) + " " +  String(selectedDay) + " " +  String(currentYear))
                }
                tasksTable.reloadData()
                myViewController.reloadData()
            }
        }
    }

    


}
