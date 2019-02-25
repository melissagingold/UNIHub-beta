//
//  MainMenuViewController.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 2/5/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth

class MainMenuViewController: UIViewController {
    
    @IBAction func toGrades(_ sender: UIButton) {
    }
    
    
    @IBAction func toEssay(_ sender: UIButton) {
    }
    
    
    @IBAction func toActivities(_ sender: UIButton) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showCollegeProfile), name: NSNotification.Name("showCollegeProfile"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showChecklist), name: NSNotification.Name("showChecklist"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showCalendar), name: NSNotification.Name("showCalendar"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showLogOut), name: NSNotification.Name("showLogOut"), object: nil)
        
    }
    
    @objc func showCollegeProfile() {
        performSegue(withIdentifier: "showCollegeProfile", sender: nil)
    }
    
    @objc func showChecklist() {
        performSegue(withIdentifier: "showChecklist", sender: nil)
    }
    
    @objc func showCalendar() {
        performSegue(withIdentifier: "showCalendar", sender: nil)
    }
    
    @objc func showLogOut() {
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
        
        performSegue(withIdentifier: "showLogOut", sender: nil)
    }
    
    @IBAction func onMoreTapped(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
}

