//
//  CollegeProfileViewController.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 2/1/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct CellData {
    let message: String?
}

class CollegeProfileViewController: UITableViewController {
    
    var data = [CellData]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        data = [CellData.init(message: "hello world"),CellData.init(message: "hello world"),CellData.init(message: "hello world"),CellData.init(message: "hello world"),CellData.init(message: "hello world"),CellData.init(message: "hello world")]
        
        self.tableView.register(CollegeCell.self, forCellReuseIdentifier: "college")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "college") as! CollegeCell
        cell.message = data[indexPath.row].message
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
}
