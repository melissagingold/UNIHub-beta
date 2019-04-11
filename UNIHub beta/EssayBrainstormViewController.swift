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
