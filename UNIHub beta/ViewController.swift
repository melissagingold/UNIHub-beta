//
//  ViewController.swift
//  UNIHub beta
//
//  Created by Melissa Gingold (student LM) on 2/1/19.
//  Copyright © 2019 Melissa Gingold (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toLogIn", sender: self)
        
        
    }

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSignUp", sender: self)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        imageView.layer.cornerRadius = 30.0
        imageView.clipsToBounds = true
            }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = Auth.auth().currentUser {
            self.performSegue(withIdentifier: "toHomeScreen", sender: self)
        }
    }
}

