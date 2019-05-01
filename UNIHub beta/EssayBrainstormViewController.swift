//
//  EssayBrainstormViewController.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 3/26/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit

class EssayBrainstormViewController: UIViewController, UITextViewDelegate {
    
    var essay : Essay?

    // label / slider variables
    @IBOutlet weak var essayListName: UILabel!
    @IBOutlet weak var essaySlider: UISlider!
    @IBOutlet weak var suppLabel: UILabel!
    
    // text view variables
    @IBOutlet weak var brainstormMain: UITextView!
    @IBOutlet weak var wordLimit: UITextView!
    
    @IBOutlet weak var supp1: UITextView!
    @IBOutlet weak var supp2: UITextView!
    @IBOutlet weak var supp3: UITextView!
    @IBOutlet weak var supp4: UITextView!
    @IBOutlet weak var supp5: UITextView!
    
    // constraint variables
    @IBOutlet weak var supp1Constraint: NSLayoutConstraint!
    @IBOutlet weak var supp2Constraint: NSLayoutConstraint!
    @IBOutlet weak var supp3Constraint: NSLayoutConstraint!
    @IBOutlet weak var supp4Constraint: NSLayoutConstraint!
    @IBOutlet weak var supp5Constraint: NSLayoutConstraint!
    
    
    // changing constraints with slider value - will bring supplementals onto the screen
    @IBAction func sliderAction(_ sender: UISlider) {
        suppLabel.text = String(Int(sender.value))
        
        if Int(sender.value) == 1 {
            supp1Constraint.constant = 20
            supp2Constraint.constant = 2000
            supp3Constraint.constant = 2000
            supp4Constraint.constant = 2000
            supp5Constraint.constant = 2000
            supp1Constraint.isActive = true
        }
        else if Int(sender.value) == 2 {
            supp1Constraint.constant = 20
            supp2Constraint.constant = 20
            supp3Constraint.constant = 2000
            supp4Constraint.constant = 2000
            supp5Constraint.constant = 2000
            supp2Constraint.isActive = true
        }
        else if Int(sender.value) == 3 {
            supp1Constraint.constant = 20
            supp2Constraint.constant = 20
            supp3Constraint.constant = 20
            supp4Constraint.constant = 2000
            supp5Constraint.constant = 2000
            supp3Constraint.isActive = true
        }
        else if Int(sender.value) == 4 {
            supp1Constraint.constant = 20
            supp2Constraint.constant = 20
            supp3Constraint.constant = 20
            supp4Constraint.constant = 20
            supp5Constraint.constant = 2000
            supp4Constraint.isActive = true
        }
        else if Int(sender.value) == 5 {
            supp1Constraint.constant = 20
            supp2Constraint.constant = 20
            supp3Constraint.constant = 20
            supp4Constraint.constant = 20
            supp5Constraint.constant = 20
            supp5Constraint.isActive = true
        }
        else {
            supp1Constraint.constant = 2000
            supp2Constraint.constant = 2000
            supp3Constraint.constant = 2000
            supp4Constraint.constant = 2000
            supp5Constraint.constant = 2000
        }
    }
    
    // for firebase- adding the text from each textview to brainstorms list to save if text was entered
    func textViewDidChange(_ textView: UITextView) {
        if textView.isEqual(brainstormMain){
            essay?.brainstorms[1] = textView.text
        }
        else if textView.isEqual(supp1){
            essay?.brainstorms[2] = textView.text
        }
        else if textView.isEqual(supp2){
            essay?.brainstorms[3] = textView.text
        }
        else if textView.isEqual(supp3){
            essay?.brainstorms[4] = textView.text
        }
        else if textView.isEqual(supp4){
            essay?.brainstorms[5] = textView.text
        }
        else if textView.isEqual(supp5){
            essay?.brainstorms[6] = textView.text
        }
        else if textView.isEqual(wordLimit){
            essay?.brainstorms[0] = textView.text
        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting as default values of the essay variable (for saving to firebase)
        essayListName.text = essay?.name
        wordLimit.text = essay?.brainstorms[0]
        brainstormMain.text = essay?.brainstorms[1]
        supp1.text = essay?.brainstorms[2]
        supp2.text = essay?.brainstorms[3]
        supp3.text = essay?.brainstorms[4]
        supp4.text = essay?.brainstorms[5]
        supp5.text = essay?.brainstorms[6]
        
        // for keeping the supplemental text views on screen
        if supp5.text! != "" {
            essaySlider.setValue(5, animated: true)
        }
        else if supp4.text! != "" {
            essaySlider.setValue(4, animated: true)
        }
        else if supp3.text! != "" {
            essaySlider.setValue(3, animated: true)
        }
        else if supp2.text! != "" {
            essaySlider.setValue(2, animated: true)
        }
        else if supp1.text! != "" {
            essaySlider.setValue(1, animated: true)
        }
        else{
           essaySlider.setValue(0, animated: true)
        }
        sliderAction(essaySlider)

    }
}

// essay class- holds default values for each essay (name and text from each textview)
class Essay {
    var name : String
    var brainstorms : [String]
    
    init(name : String) {
        self.name = name
        self.brainstorms = ["","","","","","",""]
    }
}
