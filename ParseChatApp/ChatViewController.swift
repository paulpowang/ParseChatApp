//
//  ChatViewController.swift
//  ParseChatApp
//
//  Created by paul on 9/22/18.
//  Copyright © 2018 PoHung Wang. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject] = []
    let logoutSegue = "logoutSegue"
    
    
    
    
    
    @IBOutlet weak var chatMessageInput: UITextField!
    
    @IBAction func sendBtn(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageInput.text ?? ""
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                
                self.chatMessageInput.text = ""
                print("The message was saved!")
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    
    @IBAction func logoutBtn(_ sender: Any) {
        PFUser.logOut()
        //performSegue(withIdentifier: logoutSegue, sender: nil)
        
    }
    
    
    //Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        // Auto size row height based on cell autolayout constraints
        tableView.rowHeight = UITableView.automaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 100
        queryMessage()
        //Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = messages[indexPath.row]
        let chatingMessage = message["text"] as! String
        cell.chatMessage.text = chatingMessage
        
        
        if let user = message["user"] as? PFUser {
            // User found! update username label with username
            cell.username.text = user.username
        } else {
            // No user found, set default username
            cell.username.text = "🤖"
        }
        
        return cell
    }
    
    
    func queryMessage(){
        // construct query
        let query = PFQuery(className: "Message")
        
        //query.whereKey("likesCount", greaterThan: 100)
        query.includeKey("user")
        //query.limit = 20
        //sort the result by create time
        query.addDescendingOrder("createdAt")
        
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                // do something with the array of object returned by the call
                for message in posts{
                    print(message["text"])
                }
                
                self.messages = posts
                self.tableView.reloadData()
                
                
            } else {
                print(error?.localizedDescription)
            }
            
        }
        
        
        
    }
    
    //function that run every seconds
    @objc func onTimer() {
        // Add code to be run periodically
        
        queryMessage()
    }

}
