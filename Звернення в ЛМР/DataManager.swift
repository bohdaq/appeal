//
//  DataManager.swift
//  EAppeal
//
//  Created by Prodeus Roman		 on 2/7/16.
//  Copyright © 2016 Prodeus Roman		. All rights reserved.
//

import Foundation

class DataManager{
    
    static let sharedInstance = DataManager()
    
    
    private let nameDefaultsKey: String = "name"
    private let addressDefaltsKey: String = "address"
    private let emailDefaultsKey: String = "email"
    private let phoneDefaultsKey: String = "phone"
    
    
    private init(){
        
    }
    
    
    func saveUser(user: User){
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(user.name, forKey: nameDefaultsKey)
        defaults.setObject(user.address, forKey: addressDefaltsKey)
        defaults.setObject(user.email, forKey: emailDefaultsKey)
        defaults.setObject(user.phone, forKey: phoneDefaultsKey)
    }
    
    
    func getUser() -> User? {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let name: String? = defaults.stringForKey(nameDefaultsKey)
        let address: String? = defaults.stringForKey(addressDefaltsKey)
        let email: String? = defaults.stringForKey(emailDefaultsKey)
        let phone: String? = defaults.stringForKey(phoneDefaultsKey)
        
        guard name != nil && address != nil && email != nil && phone != nil else {
            return nil
        }
        
        return User(name: name!, address: address!, email: email!, phone: phone!)
    }
}
