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

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func signUpButtonTouchedUp(_ sender: UIButton) {
        guard let userName = userNameTextField.text else {return}
        guard let email = emailAddressTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil, error == nil {
                print("user created")
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print(error.debugDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        emailAddressTextField.delegate = self
        passwordTextField.delegate = self
        
        userNameTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if userNameTextField.isFirstResponder {
            emailAddressTextField.becomeFirstResponder()
        }
        else if emailAddressTextField.isFirstResponder {
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
