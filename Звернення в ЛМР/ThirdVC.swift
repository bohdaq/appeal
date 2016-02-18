//
//  ThirdVC.swift
//  Звернення в ЛМР
//
//  Created by Bogdan on 2/5/16.
//  Copyright © 2016 Bogdan Tsap. All rights reserved.
//

import UIKit

class ThirdVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    
    @IBAction func doneTapped(sender: AnyObject) {
        let initVC = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController")
        self.navigationController?.pushViewController(initVC!, animated: true)
    }
    
}
