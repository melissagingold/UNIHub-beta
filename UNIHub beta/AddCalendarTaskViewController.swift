//
//  AddCalendarTaskViewController.swift
//  UNIHub beta
//
//  Created by Charles Herrmann (student LM) on 4/10/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit

protocol AddCalendarTask {
    func addCalendarTask(id: String, task: String)
}

class AddCalendarTaskViewController: UIViewController, UITextViewDelegate {
    var key = ""
    
    @IBOutlet weak var taskText: UITextView!
    var delegate: AddCalendarTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskText.text = "Add new task..."
        taskText.textColor = UIColor.lightGray
        taskText.font = UIFont(name: "Helvetica Neue", size: 22.0)
        taskText.returnKeyType = .done
        taskText.delegate = self
        
    }

    @IBAction func enter(_ sender: UIButton) {
        delegate?.addCalendarTask(id: key, task: taskText.text!)
        navigationController?.popViewController(animated: true)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if taskText.text == "Add new task..." {
            taskText.text = ""
            taskText.textColor = UIColor.black
            taskText.font = UIFont(name: "Helvetica Neue", size: 22.0)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            taskText.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if taskText.text == "" {
            taskText.text = "Add new task..."
            taskText.textColor = UIColor.lightGray
            taskText.font = UIFont(name: "Helvetica Neue", size: 22.0)
        }
    }
    
   
    
}
