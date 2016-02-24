//
//  ViewController.swift
//  Звернення в ЛМР
//
//  Created by Bogdan on 2/5/16.
//  Copyright © 2016 Bogdan Tsap. All rights reserved.
//

import UIKit
import SwiftSpinner
import SwiftyJSON


class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var nextBtn: UIBarButtonItem!
    
    var keyboardIsShown = false
    
    let user = User.sharedInstance
    
    func logMissingField(msg: String){
        print("Введіть " + msg)
    }
    
    @IBAction func firstNameTapped(sender: AnyObject) {
        decideEnableNext()
    }
    
    @IBAction func lastNameTapped(sender: AnyObject) {
        decideEnableNext()
    }
    
    @IBAction func addressTapped(sender: AnyObject) {
        decideEnableNext()
    }
    
    @IBAction func phoneTapped(sender: AnyObject) {
        decideEnableNext()
    }
    
    @IBAction func emailTapped(sender: AnyObject) {
        decideEnableNext()
    }
    
    @IBAction func writeTapped(sender: AnyObject) {
        
        user.email = email.text!
        user.phone = phone.text!
        user.address = address.text!
        user.name = firstName.text! + " " + lastName.text!
        
        user.saveUser()
        
        SwiftSpinner.show("Входимо в систему...")
        ApiCaller.login({
            
            dispatch_async(dispatch_get_main_queue(),{ () -> () in
                SwiftSpinner.hide()
                let secondStepVC = self.storyboard?.instantiateViewControllerWithIdentifier("SecondStepVC")
                self.navigationController?.pushViewController(secondStepVC!, animated: true)
            })
            }, onErrorCallback: {
                SwiftSpinner.hide()
                let refreshAlert = UIAlertController(title: "Error", message: "Some error occured!", preferredStyle: UIAlertControllerStyle.Alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                self.presentViewController(refreshAlert, animated: true, completion: nil)
                
        })
    }
    
    func decideEnableNext(){
        if firstName.text!.isBlank {
            nextBtn.enabled = false
        } else if lastName.text!.isBlank {
            nextBtn.enabled = false
        } else if address.text!.isBlank {
            nextBtn.enabled = false
        } else if phone.text!.isBlank || !phone.text!.isPhoneNumber {
            nextBtn.enabled = false
        } else if email.text!.isBlank || !email.text!.isEmail {
            nextBtn.enabled = false
        } else {
            nextBtn.enabled = true
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        if user.getUser() == nil {
            nextBtn.enabled = false
        } else {
            firstName.text = user.name.componentsSeparatedByString(" ")[0]
            lastName.text = user.name.componentsSeparatedByString(" ")[1]
            if user.address != "" {
                address.text = user.address
            }
            phone.text = user.phone
            email.text = user.email
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        firstName.delegate = self
        lastName.delegate = self
        address.delegate = self
        email.delegate = self
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if !keyboardIsShown {
                keyboardIsShown = true
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
            keyboardIsShown = false
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //delegate method
        dismissKeyboard()
        return true
    }
    
}

