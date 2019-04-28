//
//  SideMenuTableViewController.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 2/5/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {

    let backgroundImage = UIImage(named: "gray.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // image to background
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = nil
        
        imageView.contentMode = .scaleAspectFill
        
        self.tableView.backgroundView = imageView
        
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        
        switch indexPath.row {
        case 0: NotificationCenter.default.post(name: NSNotification.Name("showCollegeProfile"), object: nil)
        case 1: NotificationCenter.default.post(name: NSNotification.Name("showCalendar"), object: nil)
        case 2: NotificationCenter.default.post(name: NSNotification.Name("showChecklist"), object: nil)
        case 3: NotificationCenter.default.post(name: NSNotification.Name("showLogOut"), object: nil)
        default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 0.97, alpha: 1)
    }
}
