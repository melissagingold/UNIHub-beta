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
    @IBOutlet weak var collegeLocation: UILabel!
    @IBOutlet weak var collegeAverageSATScore: UILabel!
    
    var college: College?
    
    
    @IBAction func openWebsite(_ sender: UIButton) {
        //performSegue(withIdentifier: "openWebsite", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collegeLocation.numberOfLines = 1
        
        collegeName.text = college!.name
        collegeLocation.text = college!.location
        collegeAverageSATScore.text = "sat score: \(college!.averageSATScore)"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as? UIButton) != nil {
            let webViewController = segue.destination as! WebViewController
            webViewController.url = URL(string: college?.url ?? "")
        }
    }

}
