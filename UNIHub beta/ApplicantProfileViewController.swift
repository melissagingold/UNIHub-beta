//
//  ApplicantProfileViewController.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 2/1/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class ApplicantProfileViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    

    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        testPicker.selectRow(testPicker.numberOfRows(inComponent: 0)/2, inComponent: 0, animated: true)
    
        // Do any additional setup after loading the view.
    }
    
    
    
    //pciker view to select ACT or SAT
    @IBOutlet weak var testPicker: UIPickerView!
    let test = ["SAT:", "ACT:"]
    
    func pickerView(testPicker : UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: "row")
        defaults.synchronize()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return test.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(test[row])"
    }
    
    
    
    
    
    //textFields
    @IBOutlet weak var GPAText: UITextField!
    @IBOutlet weak var scoreText: UITextField!
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
