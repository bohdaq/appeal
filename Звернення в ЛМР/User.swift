//
//  User.swift
//  EAppeal
//
//  Created by Prodeus Roman		 on 2/7/16.
//  Copyright © 2016 Prodeus Roman		. All rights reserved.
//

import Foundation

class User {
    
    private let nameDefaultsKey: String = "name"
    private let addressDefaltsKey: String = "address"
    private let emailDefaultsKey: String = "email"
    private let phoneDefaultsKey: String = "phone"
    
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
    
    
    func saveUser() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(name, forKey: nameDefaultsKey)
        defaults.setObject(address, forKey: addressDefaltsKey)
        defaults.setObject(email, forKey: emailDefaultsKey)
        defaults.setObject(phone, forKey: phoneDefaultsKey)
    }
    
    func getUser() -> User? {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let name: String? = defaults.stringForKey(nameDefaultsKey)
        let address: String? = defaults.stringForKey(addressDefaltsKey)
        let email: String? = defaults.stringForKey(emailDefaultsKey)
        let phone: String? = defaults.stringForKey(phoneDefaultsKey)
        
        guard name != nil && email != nil && phone != nil else {
            return nil
        }
        
        if address != nil {
            self.address = address!
        }
        
        self.name = name!
        self.phone = phone!
        self.email = email!
        
        return self
    }
    
    func removeUser() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setNilValueForKey(nameDefaultsKey)
        defaults.setNilValueForKey(addressDefaltsKey)
        defaults.setNilValueForKey(emailDefaultsKey)
        defaults.setNilValueForKey(phoneDefaultsKey)
    }
}