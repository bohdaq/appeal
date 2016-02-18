//
//  ViewController.swift
//  Звернення в ЛМР
//
//  Created by Bogdan on 2/5/16.
//  Copyright © 2016 Bogdan Tsap. All rights reserved.
//

import UIKit
import SwiftSpinner

class ViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    let user = User.sharedInstance
    
    func showAlert(msg: String){
        SwiftSpinner.show("Введіть " + msg, animated: false).addTapHandler ({
            SwiftSpinner.hide()
        })
    }
    
    @IBAction func writeTapped(sender: AnyObject) {
        if firstName.text == "" {
            showAlert("ім'я")
        } else if lastName.text == "" {
            showAlert("прізвище")
        } else if address.text == "" {
            showAlert("адресу")
        } else if phone.text == "" {
            showAlert("телефон")
        } else if email.text == "" {
            showAlert("email")
        } else {
            user.email = email.text!
            user.phone = phone.text!
            user.address = address.text!
            user.name = firstName.text! + " " + lastName.text!
            
            SwiftSpinner.show("Входимо в систему...")
            ApiCaller.login({(data, response, error) in
                
                guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                    print("error")
                    return
                }
                
                let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print(dataString)
                
                dispatch_async(dispatch_get_main_queue(),{ () -> () in
                    SwiftSpinner.hide()
                    let secondStepVC = self.storyboard?.instantiateViewControllerWithIdentifier("SecondStepVC")
                    self.navigationController?.pushViewController(secondStepVC!, animated: true)
                })
                
                
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
}

