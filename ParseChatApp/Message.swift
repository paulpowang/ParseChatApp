//
//  Message.swift
//  ParseChatApp
//
//  Created by paul on 9/22/18.
//  Copyright © 2018 PoHung Wang. All rights reserved.
//

import Foundation

class Message{
    
    private var _username: String = ""
    private var _message: String = ""
    
    init(username: String, message: String){
        _username = username
        _message = message
    }
    
    var username: String {
        return _username
    }
    
    var message: String{
        return _message
    }
}
