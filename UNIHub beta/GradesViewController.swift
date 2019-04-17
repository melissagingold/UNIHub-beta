//
//  ActivityViewController.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 2/25/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class GradesViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate {
    //
    @IBOutlet weak var testPicker: UIPickerView!
    let test = ["SAT:", "ACT:"]
    var apScores: [String?] = []
    var satScores: [String?] = []
    
    //tiles
    @IBOutlet weak var viewTest: UIView!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var apTestView: UIView!
    @IBOutlet weak var sat2View: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testPicker.selectRow(testPicker.numberOfRows(inComponent: 0)/2, inComponent: 0, animated: true)
        
        // Do any additional setup after loading the view.
        GPAText.delegate = self
        scoreText.delegate = self
        
        GPAText.becomeFirstResponder()
        
        
        //tiles
        viewTest.isHidden = true
        scoreView.isHidden = true
        apTestView.isHidden = true
        sat2View.isHidden = true
    }
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if GPAText.isFirstResponder{
            //gpaTests.append(GPAText.text)
            scoreText.becomeFirstResponder()
        }
        else{
            self.view.endEditing(true)
            scoreText.resignFirstResponder()
           // gpaTests.append(scoreText.text)
        }
        return true
    }
    
    
    //adding AP Tests
    @IBOutlet weak var addAPTestText: UITextField!
    @IBOutlet weak var addAPTestScore: UITextField!
    @IBOutlet weak var APTestList2: UITextView!
    
    @IBAction func addAPTest(_ sender: UIButton) {
        apScores.append("\(addAPTestText.text):\(addAPTestScore.text)")
        
        if let text = addAPTestText.text{
            if text == "" {
                return
            }
            APTestList2.text?.append("\(text)")
            addAPTestText.text = ""
            addAPTestScore.resignFirstResponder()
        }
        
        if let text2 = addAPTestScore.text{
            if text2 == ""{
                return
            }
            APTestList2.text?.append(":\(text2)\n")
            addAPTestScore.text = ""
            addAPTestText.resignFirstResponder()
        }
    }
    
    //adding SAT2 Tests
    @IBOutlet weak var addSAT2Text: UITextField!
    @IBOutlet weak var SAT2List: UITextView!
    @IBOutlet weak var addSAT2Score: UITextField!
    
    @IBAction func addSAT2Test(_ sender: UIButton) {
        satScores.append("\(addSAT2Text.text):\(addSAT2Score.text)")
        if let text = addSAT2Text.text{
            if text == ""{
                return
            }
            SAT2List.text?.append("\(text)")
            addSAT2Text.text = ""
            addSAT2Text.resignFirstResponder()
        }
        if let text2 = addSAT2Score.text{
            if text2 == ""{
                return
            }
            SAT2List.text?.append(":\(text2)\n")
            addSAT2Score.text = ""
            addSAT2Text.resignFirstResponder()
        }
    }
    
    func saveGrades(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("user/\(uid)/Grades")
        var grades = [[String: String]]()
        var apDict = [String : String]()
        for score in apScores {
            //apDict.updateValue(String(Array((score?.split(separator: ":"))!)[1]), forKey: score?.split(separator: ":")[0])
        }
        grades.append(apDict)
        ref.setValue(grades)
    }
    
    
    //tiles
    @IBAction func buttonTesting(_ sender: UIButton) {
        if viewTest.isHidden == false{
            viewTest.isHidden = true
        }
        else{
            viewTest.isHidden = false
        }
    }
    
    @IBAction func scoresButton(_ sender: UIButton) {
        if scoreView.isHidden == false{
            scoreView.isHidden = true
        }
        else{
            scoreView.isHidden = false
        }
    }
    
    @IBAction func apTestTile(_ sender: UIButton) {
        if apTestView.isHidden == false{
            apTestView.isHidden = true
        }
        else{
            apTestView.isHidden = false
        }
    }
    
    @IBAction func sat2Tile(_ sender: UIButton) {
        if sat2View.isHidden == false{
            sat2View.isHidden = true
        }
        else{
            sat2View.isHidden = false
        }
    }
    
    
}


