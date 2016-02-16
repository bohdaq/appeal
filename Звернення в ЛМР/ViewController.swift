//
//  ViewController.swift
//  Звернення в ЛМР
//
//  Created by Bogdan on 2/5/16.
//  Copyright © 2016 Bogdan Tsap. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    @IBAction func writeTapped(sender: AnyObject) {
        if email.text == "" {
            
        } else if phone.text == "" {
            
        } else if address.text == "" {
            
        } else if firstName.text == "" {
            
        } else if firstName.text == "" {
            
        } else if lastName == "" {
            
        } else {
        
            let secondStepVC = self.storyboard?.instantiateViewControllerWithIdentifier("SecondStepVC")
            self.navigationController?.pushViewController(secondStepVC!, animated: true)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

