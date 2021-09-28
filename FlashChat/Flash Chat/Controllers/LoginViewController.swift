//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        sender.isEnabled = false
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    sender.isEnabled = true
                    let errorMessage = e.localizedDescription
                    print(e)
                    let alert = UIAlertController(title: "Warning", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OKey", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    sender.isEnabled = true
                    //Navigate to the ChatViewController
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                    
                }
            }
        }
    }
    
}
