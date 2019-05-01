//
//  SignUpViewController.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 2/1/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {

    // variables
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    // creates account with user entered email and password when button is tapped
    @IBAction func signUpButtonTouchedUp(_ sender: UIButton) {
        guard let email = emailAddressTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil, error == nil {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print(error.debugDescription)
            }
        }
    }
    
    // setting the text field delegates for editing
    override func viewDidLoad() {
        super.viewDidLoad()
        emailAddressTextField.delegate = self
        passwordTextField.delegate = self
        
        emailAddressTextField.becomeFirstResponder()
    }
    
    // succession of text field editing - after first text field is done, editing is allowed for the next
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailAddressTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        }
        else {
            self.view.endEditing(true)
            passwordTextField.resignFirstResponder()
            signUpButton.isEnabled = true
        }
        return true
    }
}
