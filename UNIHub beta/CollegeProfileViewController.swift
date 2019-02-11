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
    let collegeName: String?
    let information: String?
}

class CollegeProfileViewController: UITableViewController {
    
    var data = [CellData]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        data = [CellData.init(collegeName: "College 1",information: "college is good"),CellData.init(collegeName: "College 2",information: "college is bad"),CellData.init(collegeName: "College 3",information: "college is good college is good college is good college is good college is good college is good college is good college is good college is good college is good college is good"),CellData.init(collegeName: "College 4",information: "college is ok")]
        
        self.tableView.register(CollegeCell.self, forCellReuseIdentifier: "college")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "college") as! CollegeCell
        cell.name = data[indexPath.row].collegeName
        cell.information = data[indexPath.row].information
        cell.layoutSubviews()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
}
