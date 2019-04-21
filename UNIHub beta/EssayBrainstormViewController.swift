//
//  EssayBrainstormViewController.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 3/26/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit

class EssayBrainstormViewController: UIViewController {

    var getName = String()

    @IBOutlet weak var essayListName: UILabel!
    @IBOutlet weak var essaySlider: UISlider!
    @IBOutlet weak var suppLabel: UILabel!
    
    @IBOutlet weak var supp1Constraint: NSLayoutConstraint!
    @IBOutlet weak var supp2Constraint: NSLayoutConstraint!
    @IBOutlet weak var supp3Constraint: NSLayoutConstraint!
    @IBOutlet weak var supp4Constraint: NSLayoutConstraint!
    @IBOutlet weak var supp5Constraint: NSLayoutConstraint!
    
    
    @IBAction func sliderAction(_ sender: UISlider) {
        suppLabel.text = String(Int(sender.value))
        
        if Int(sender.value) == 1 {
            supp1Constraint.constant = 20
            supp1Constraint.isActive = true
        }
        else if Int(sender.value) == 2 {
            supp2Constraint.constant = 20
            supp2Constraint.isActive = true
        }
        else if Int(sender.value) == 3 {
            supp3Constraint.constant = 20
            supp3Constraint.isActive = true
        }
        else if Int(sender.value) == 4 {
            supp4Constraint.constant = 20
            supp4Constraint.isActive = true
        }
        else if Int(sender.value) == 5 {
            supp5Constraint.constant = 20
            supp5Constraint.isActive = true
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        essayListName.text! = getName
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
