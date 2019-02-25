//
//  ChecklistViewController.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 2/1/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit
import UserNotifications

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

        // Do any additional setup after loading the view.
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
}

class Task {
    var name = ""
    var checked = false
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
