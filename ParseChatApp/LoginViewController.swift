//
//  ViewController.swift
//  ParseChatApp
//
//  Created by paul on 9/21/18.
//  Copyright © 2018 PoHung Wang. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    var message: String = ""
    let loginSegue = "loginSegue"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    
    @IBAction func signUpBtn(_ sender: Any) {
        if (usernameInput.text?.isEmpty)! || (passwordInput.text?.isEmpty)! {
            loginViewAlert()
            
        }else{
            registerUser()
            performSegue(withIdentifier: loginSegue, sender: nil)
            
        }
        
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        if (usernameInput.text?.isEmpty)! || (passwordInput.text?.isEmpty)! {
            loginViewAlert()
            
        }else{
            
            loginUser()
            
        }
        
    }
    //if user already login and haven't logout, direct into chat view
    override func viewDidAppear(_ animated: Bool) {
        // check if user is logged in.
        if PFUser.current() != nil {
            performSegue(withIdentifier: loginSegue, sender: nil)
        }
    }
    
    func registerUser() {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameInput.text
        //newUser.email = emailField.text
        newUser.password = passwordInput.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                //self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    func loginUser() {
        
        let username = usernameInput.text ?? ""
        let password = passwordInput.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    
    
    
    func loginViewAlert(){
        
        let title = "Error"
        
        if (usernameInput.text?.isEmpty)! && (passwordInput.text?.isEmpty)!{
            message = "Please Enter Username and Password."
        }else if (usernameInput.text?.isEmpty)!{
            message = "Please Enter Username."
        }else{
            message = "Please Enter Password."
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    

}

