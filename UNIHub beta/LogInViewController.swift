//
//  LogInViewController.swift
//  UNIHub beta
//
//  Created by Chloe Cowan (student LM) on 2/1/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController, UITextFieldDelegate {
    // variables
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    // log in button - for users that already have an account
    @IBAction func logInButtonTouchedUp(_ sender: UIButton) {
        guard let emailAddress = userNameTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: emailAddress, password: password) { (user, error) in
            
            if error == nil && user != nil {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print(error!.localizedDescription)
            }
        }
    }
    
    // setting the text field delegates for editing
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        
        userNameTextField.becomeFirstResponder()
        
    }
    
    // succession of text field editing - after first text field is done, editing is allowed for the next
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if userNameTextField.isFirstResponder {
            userNameTextField.becomeFirstResponder()
        }
        else {
            self.view.endEditing(true)
            passwordTextField.resignFirstResponder()
            logInButton.isEnabled = true
        }
        
        return true
    }
}
