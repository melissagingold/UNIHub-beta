//
//  SideMenuTableViewController.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 2/5/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        
        switch indexPath.row {
        case 0: NotificationCenter.default.post(name: NSNotification.Name("showApplicantProfile"), object: nil)
        case 1: NotificationCenter.default.post(name: NSNotification.Name("showCollegeProfile"), object: nil)
        case 2: NotificationCenter.default.post(name: NSNotification.Name("showCalendar"), object: nil)
        case 3: NotificationCenter.default.post(name: NSNotification.Name("showChecklist"), object: nil)
        case 4: NotificationCenter.default.post(name: NSNotification.Name("showLogOut"), object: nil)
        default: break
        }
    }
}
