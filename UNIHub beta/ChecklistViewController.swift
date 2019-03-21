//
//  ChecklistViewController.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 2/1/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit
import UserNotifications
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class ChecklistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTask, ChangeButton {
    
    var tasks: [Task] = []
    var checks: [Bool] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        
        cell.taskNameLabel.text = tasks[indexPath.row].name
        
        if tasks[indexPath.row].checked {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxFILLED"), for: UIControl.State.normal)
        } else {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxOUTLINE"), for: UIControl.State.normal)
        }
        
        cell.delegate = self
        cell.indexP = indexPath.row
        cell.tasks = tasks
        prepareNotification()
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddTaskViewController
        vc.delegate = self
    }
    
    func addTask(name: String) {
        tasks.append(Task(name: name))
        tableView.reloadData()
    }
    
    func numOfTrue(checks: [Bool]) -> Int {
        var num = 0
        for i in checks {
            if(i) {
                num += 1
            } else {
                num -= 1
            }
        }
        return num
    }

    func changeButton(checked: Bool, index: Int?) {
        tasks[index!].checked = checked
        
        if tasks[index!].checked == true {
            checks.append(true)
        } else {
            checks.append(false)
        }
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = nil
        tableView.backgroundColor = UIColor(red:1.00, green:0.90, blue:0.50, alpha:1.0)
        
    }

func prepareNotification() {
    let content = UNMutableNotificationContent()
    
    let numberOfTrue = numOfTrue(checks: checks)
    let numberOfFalse = tasks.count - numberOfTrue
    
    content.title = "Task Reminder"
    content.subtitle = "Check out your tasks"
    content.sound = UNNotificationSound.default
    
    if(numberOfFalse > 0) {
        content.body = "You have completed \(numberOfTrue) tasks! Finish the remaining \(numberOfFalse) tasks!!"
    } else {
        content.body = "Congrats! you have accomplished all of your tasks!"
    }
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
    let request = UNNotificationRequest(identifier: "helloNotification.Request", content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
}

    func saveTasks(tasks: [Task]) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("user/\(uid)/Tasks")
        var taskDictionary : [String : String] = [:]
        for task in tasks {
            taskDictionary.updateValue(task.name, forKey: "\(task.name)")
        }
        ref.setValue(taskDictionary)
    }
    
    
    func loadTask() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("user/\(uid)/Tasks")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            let data = snapshot.value as? [String : String]
            for str in (data?.keys)! {
                self.addTask(name: str)
            }
        }
        
    }

}

class Task {
    var name = ""
    var checked = false
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
