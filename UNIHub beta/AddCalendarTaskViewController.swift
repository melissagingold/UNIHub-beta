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

class AddCalendarTaskViewController: UIViewController {
    var key = ""
    
    @IBOutlet weak var taskText: UITextView!
    var delegate: AddCalendarTask?
    

    @IBAction func enter(_ sender: UIButton) {
        delegate?.addCalendarTask(id: key, task: taskText.text!)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}
