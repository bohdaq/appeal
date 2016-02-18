//
//  SecondStepVC.swift
//  Звернення в ЛМР
//
//  Created by Bogdan on 2/5/16.
//  Copyright © 2016 Bogdan Tsap. All rights reserved.
//
import UIKit
import SwiftSpinner

class SecondStepVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var attachPhoto: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var categoryId: Int! = 1
    
    let appeal = Appeal.sharedInstance
    
    let imagePicker = UIImagePickerController()
    let mapping: [String: Int] = ["Житловокомунальне господарство": 1, "Юридична консультація": 2, "Транспорт і зв'язок": 3, "Містобудування та інфраструктура": 4, "Соціальний захист": 5, "Діти": 6, "Адміністративні послуги": 7, "Будівництво і реконструкція": 8, "Земля": 9, "Оренда майна": 10, "Рекламна вивіска": 11, "Літні майданчики, МАФи": 12]
    
    let categories = ["Житловокомунальне господарство", "Юридична консультація", "Транспорт і зв'язок", "Містобудування та інфраструктура", "Соціальний захист", "Діти", "Адміністративні послуги", "Будівництво і реконструкція", "Земля", "Оренда майна", "Рекламна вивіска", "Літні майданчики, МАФи"]
    
    @IBAction func attachPhotoTapped(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func sendTapped(sender: AnyObject) {
        appeal.categoryId = categoryId
        appeal.description = self.textView.text
        appeal.isPublic = true
        appeal.date = Int(NSDate().timeIntervalSince1970)
        appeal.image = self.imageView.image

        SwiftSpinner.show("Надсилаємо звернення (може зайняти декілька хвилин)...")

        ApiCaller.sendAppeal({(data, response, error) in
                
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print(error?.description)
                return
            }
            
            //TODO: check if HTTP RESPONSE CODE is 200
            // if so - try to parse json and get the status field
            // if status true - perform seque to ThirdVC
            // ----
            // handle all edge cases
            // 1. Send appeal without a photo attached now causing error. Figure out why and fix.
            // 2. Handle server exceptions (500 errors)
            // 3. Handle status false backend response
                
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(String(dataString))
            
            dispatch_async(dispatch_get_main_queue()) { [] in
                SwiftSpinner.hide()
                let thirdVC = self.storyboard?.instantiateViewControllerWithIdentifier("ThirdVC")
                self.navigationController?.pushViewController(thirdVC!, animated: true)
            }
        })
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        categoryId = mapping[categories[row]]
        return categories[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
        
        attachPhoto.hidden = true
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
