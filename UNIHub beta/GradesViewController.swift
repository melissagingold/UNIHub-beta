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
    // variables
    @IBOutlet weak var testPicker: UIPickerView!
    let test = ["SAT:", "ACT:"]
    var apScores: String?
    var satScores: String?
    var satScore: String?
    var actScore: String?
    var gpa: String?
    
    //tiles
    @IBOutlet weak var viewTest: UIView!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var apTestView: UIView!
    @IBOutlet weak var sat2View: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting default values
        apScores = ""
        satScores = ""
        satScore = ""
        actScore = ""
        gpa = ""
        
        // firebase - load grades
        loadGrades()
        
        // for SAT / ACT test picker (setting default)
        testPicker.selectRow(testPicker.numberOfRows(inComponent: 0)/2, inComponent: 0, animated: true)
        
        GPAText.delegate = self
        scoreText.delegate = self
        
        //tiles
        viewTest.isHidden = true
        scoreView.isHidden = true
        apTestView.isHidden = true
        sat2View.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // save grades to firebase
        saveGrades()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // for SAT / ACT picker view, setting text
        if row == 0{
            scoreText.text = satScore
        }
        else {
            scoreText.text = actScore
        }
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
        // for entering text into the GPA and score text fields
        if textField.isEqual(GPAText) {
            gpa = GPAText.text
            GPAText.resignFirstResponder()
        }
        else if textField.isEqual(scoreText) {
            if testPicker.selectedRow(inComponent: 0) == 0{
                satScore = scoreText.text
            }
            else {
                actScore = scoreText.text
            }
            self.view.endEditing(true)
            scoreText.resignFirstResponder()
        }
        return true
    }
    
    
    //adding AP Tests
    @IBOutlet weak var addAPTestText: UITextField!
    @IBOutlet weak var addAPTestScore: UITextField!
    @IBOutlet weak var APTestList2: UITextView!
    
    @IBAction func addAPTest(_ sender: UIButton) {
        if let text = addAPTestText.text, let text2 = addAPTestScore.text {
            if text == "" {
                return
            }
            APTestList2.text?.append("\(text)")
            addAPTestText.text = ""
            addAPTestScore.resignFirstResponder()
            if text2 == ""{
                return
            }
            APTestList2.text?.append(": \(text2)\n")
            addAPTestScore.text = ""
            addAPTestText.resignFirstResponder()
        }
    }
    
    //adding SAT2 Tests
    @IBOutlet weak var addSAT2Text: UITextField!
    @IBOutlet weak var SAT2List: UITextView!
    @IBOutlet weak var addSAT2Score: UITextField!
    
    @IBAction func addSAT2Test(_ sender: UIButton) {
        if let text = addSAT2Text.text, let text2 = addSAT2Score.text {
            if text == ""{
                return
            }
            SAT2List.text?.append("\(text)")
            addSAT2Text.text = ""
            addSAT2Text.resignFirstResponder()
            if text2 == ""{
                return
            }
            SAT2List.text?.append(": \(text2)\n")
            addSAT2Score.text = ""
            addSAT2Text.resignFirstResponder()
        }
    }
    
    // firebase - loading grades
    func loadGrades(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("user/\(uid)/Grades")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? [[String : String]] {
                self.gpa = Array(data[0].values)[0]
                self.GPAText.text = self.gpa
                self.satScore =  Array(data[1].values)[0]
                self.actScore =  Array(data[2].values)[0]
                self.apScores =  Array(data[3].values)[0]
                self.APTestList2.text = self.apScores
                self.satScores =  Array(data[4].values)[0]
                self.SAT2List.text = self.satScores
            }
            self.testPicker.reloadAllComponents()
        }
    }
    
    // firebase - saving grades
    func saveGrades(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("user/\(uid)/Grades")
        var grades = [[String : String]]()
        apScores = APTestList2.text
        satScores = SAT2List.text
        grades.append(["GPA" : gpa!])
        grades.append(["SAT" : satScore!])
        grades.append(["ACT" : actScore!])
        grades.append(["AP" : apScores!])
        grades.append(["SAT2" : satScores!])
        ref.setValue(grades)
    }
    
    
    //tiles - when tapped, show the text boxes for grades + scores
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


