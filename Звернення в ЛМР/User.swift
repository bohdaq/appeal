//
//  User.swift
//  EAppeal
//
//  Created by Prodeus Roman		 on 2/7/16.
//  Copyright © 2016 Prodeus Roman		. All rights reserved.
//

import Foundation

class User {
    static let sharedInstance = User()
    
    init(){}
    
    init(name: String, address: String, email: String, phone: String){
        self.name = name
        self.address = address
        self.email = email
        self.phone = phone
    }
    
    var name: String = ""
    
    var address: String = ""
    
    var email: String = ""
    
    var phone: String = ""
}