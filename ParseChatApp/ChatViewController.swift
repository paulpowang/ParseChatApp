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
    @IBOutlet weak var chatMessageInput: UITextField!
    
    var messages: [PFObject] = []
    let currentUser = PFUser.current()
    var refreshControl: UIRefreshControl!
    
    
    @IBAction func sendBtn(_ sender: Any) {
        
        let chatMessage = PFObject(className: "Message")
        
        chatMessage["user"] = PFUser.current()
        
        chatMessage["text"] = chatMessageInput.text ?? ""
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                //self.queryMessage()
                self.chatMessageInput.text = ""
                //self.tableView.reloadData()
                
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    /*
    @IBAction func logoutBtn(_ sender: Any) {
        PFUser.logOut()
        
        dismiss(animated: true, completion: nil)
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        // Auto size row height based on cell autolayout constraints
        //tableView.rowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 50
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ChatViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        queryMessage()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl)
    {
        queryMessage()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = messages[indexPath.row]
        let chatMessage = message["text"] as! String
        cell.chatMessage.text = chatMessage
        
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
        //query.addDescendingOrder("createdAt")
        //query.includeKey("user")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                
                for message in posts{
                    print(message["text"])
                }
                
                self.messages = posts
                //let str: String = self.messages[1]["text"] as! String
                
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    //function that run every seconds
    @objc func onTimer() {
        // Add code to be run periodically
        queryMessage()
    }

}
