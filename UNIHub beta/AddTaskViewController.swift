//
//  AddTaskViewController.swift
//  
//
//  Created by Chloe Cowan (student LM) on 2/3/19.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

protocol AddTask {
    func addTask(name: String)
}

class AddTaskViewController: UIViewController {
    @IBOutlet weak var taskNameOutlet: UITextField!
    @IBOutlet weak var dueDateOutlet: UITextField!
    
    var dueDateText : String?
    
    private var datePicker : UIDatePicker?
    
    
    // adding text field text to task
    @IBAction func addAction(_ sender: UIButton) {
        if taskNameOutlet.text != ""  {
            let fullTaskName = taskNameOutlet.text! + " " + dueDateText!
            delegate?.addTask(name: fullTaskName)
            navigationController?.popViewController(animated: true)
        } else if taskNameOutlet.text != "" {
            delegate?.addTask(name: taskNameOutlet.text!)
            navigationController?.popViewController(animated: true)
        } else {
            createAlert(title: "WARNING", message: "No tasks have been entered!")
        }
    }
    
    var delegate: AddTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(AddTaskViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        dueDateOutlet.inputView = datePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddTaskViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        dueDateOutlet.text = dateFormatter.string(from: datePicker.date)
        dueDateText = dueDateOutlet.text
        
        view.endEditing(true)
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Enter Task", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
