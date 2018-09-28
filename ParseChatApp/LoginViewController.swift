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
        PFUser.logOut()
        
    }

    
    @IBAction func signUpBtn(_ sender: Any) {
        
        // initialize a user object
        let newUser = PFUser()
        
        newUser.username = usernameInput.text
        newUser.password = passwordInput.text
        newUser.signUpInBackground{
            (success: Bool, error: Error?) in
            
            if let error = error {
                if(newUser.username?.isEmpty)! || (newUser.password?.isEmpty)!{
                    self.loginViewAlert()
                }
                switch error._code{
                case 202:
                    self.existAlert()
                    break
                default:
                    break
                }
                print(error.localizedDescription)
            }else {
                print("Create a new account")
                //  self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        if (usernameInput.text?.isEmpty)! || (passwordInput.text?.isEmpty)! {
            loginViewAlert()
            
        }else{
            
            loginUser()
            
        }
        
    }
    
    
    
    func loginUser() {
        
        let username = usernameInput.text ?? ""
        let password = passwordInput.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                }
                alertController.addAction(OKAction)
                DispatchQueue.global().async(execute: {
                    DispatchQueue.main.sync{
                        self.present(alertController, animated: true, completion: nil)
                    }
                })
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
    
    func existAlert() {
        let alertController = UIAlertController(title: "User has already existed", message: "Please enter a valid username", preferredStyle: .alert)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    

}

