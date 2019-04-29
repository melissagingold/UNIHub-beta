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

class AddTaskViewController: UIViewController, UITextViewDelegate {
    // variables
    @IBOutlet weak var dueDateOutlet: UITextField!
    @IBOutlet weak var taskNameOutlet: UITextView!
    @IBOutlet weak var button: UIButton!
    
    var dueDateText : String?
    
    private var datePicker : UIDatePicker?
    
    // adding text field text to task
    @IBAction func addAction(_ sender: UIButton) {
        if taskNameOutlet.text != "" && dueDateText != nil {
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
        
        // default for the date picker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(AddTaskViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        dueDateOutlet.inputView = datePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddTaskViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        // setting default text in text view
        placeHolderText()
        
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
    }
    
    func placeHolderText() {
        taskNameOutlet.text = "Add new task..."
        taskNameOutlet.textColor = UIColor.lightGray
        taskNameOutlet.font = UIFont(name: "Helvetica Neue", size: 22.0)
        taskNameOutlet.returnKeyType = .done
        taskNameOutlet.delegate = self
    }
    
    // for when the user clicks on the text view again, re-setting default text
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Add new task..." {
            textView.text = ""
            textView.textColor = UIColor.black
            textView.font = UIFont(name: "Helvetica Neue", size: 22.0)
        }
    }
    
    // when the user hits the enter key, resign keyboard
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    // more placeholder text
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Add new task..."
            textView.textColor = UIColor.lightGray
            textView.font = UIFont(name: "Helvetica Neue", size: 22.0)
        }
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
   // changing the due date text if changed
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        dueDateOutlet.text = dateFormatter.string(from: datePicker.date)
        dueDateText = dueDateOutlet.text
        
        view.endEditing(true)
    }
    
    // alert for if the user doesn't enter a task
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Enter Task", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
