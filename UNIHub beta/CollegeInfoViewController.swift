//
//  CollegeInfoViewController.swift
//  UNIHub beta
//
//  Created by Niklas Pant (student LM) on 2/26/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit

class CollegeInfoViewController: UIViewController {

    @IBOutlet weak var collegeName: UILabel!
    @IBOutlet weak var collegeDescription: UILabel!
    
    var college: College?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collegeDescription.numberOfLines = 0
        
        collegeName.text = college!.name
        collegeDescription.text = college!.description
        
    }
    

}
