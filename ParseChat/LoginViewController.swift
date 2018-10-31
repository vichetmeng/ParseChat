//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Vichet Meng on 10/30/18.
//  Copyright © 2018 Vichet Meng. All rights reserved.

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onLogin(_ sender: Any) {
        if usernameTextField.text == "" || passwordTextField.text == "" {
            loginOrSignupAlert(withMessage: "Username field or password field cannot be empty!")
        } else {
            PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
                if user != nil {
                    print("logged in")
                    self.performSegue(withIdentifier: "LoginPageToHome", sender: nil)
                } else {
                    if let error = error {
                        self.loginOrSignupAlert(withMessage: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    @IBAction func onSignup(_ sender: Any) {
        
        if usernameTextField.text == "" || passwordTextField.text == "" {
            loginOrSignupAlert(withMessage:"Username field or password field cannot be empty!")
        } else {
            let newUser = PFUser()
            newUser.username = usernameTextField.text!
            newUser.password = passwordTextField.text!
            
            newUser.signUpInBackground { (success, error) in
                if success {
                    print("succesfully signed up")
                    self.performSegue(withIdentifier: "LoginPageToHome", sender: nil)
                } else {
                    if let error = error {
                        self.loginOrSignupAlert(withMessage: error.localizedDescription)
                        
                    }
                }
            }
        }
        
        
        
        
    }
    
    private func loginOrSignupAlert(withMessage message:String) {
        let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alertView.addAction(alertAction)
        present(alertView, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
