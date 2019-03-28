//
//  AddActivityViewController.swift
//  UNIHub beta
//
//  Created by Melissa Gingold (student LM) on 3/21/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var activName: UITextField!
    @IBOutlet weak var activPartic: UITextField!
    @IBOutlet weak var activPosit: UITextField!
    @IBOutlet weak var activHon: UITextField!
    
    var diffActivs = [[String?]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        addArr()
    }
    
    
    func addArr(){
        let otherVC = ApplicantProfileViewController()
        diffActivs = otherVC.diffActivs
    }
    
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        var tempArr = [activName.text, activPartic.text, activPosit.text, activHon.text]
        
        diffActivs[1] = tempArr
        
//        for i in 0..<9{
//            if diffActivs[i] == ["","","",""]{
//                diffActivs[i] = tempArr
//                tempArr = ["","","",""]
//            }
    }

    
//        for i in 0..<diffActivs.count{
//            if diffActivs[i][0] == ""{
//                diffActivs[i][0] = tempArr[0]
//                tempArr = [" ", " "," "," "]
//            }
//        }
    
    
    
    func addActiv(){
    }
    
    
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


