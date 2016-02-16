//
//  SecondStepVC.swift
//  Звернення в ЛМР
//
//  Created by Bogdan on 2/5/16.
//  Copyright © 2016 Bogdan Tsap. All rights reserved.
//
import UIKit

class SecondStepVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var attachPhoto: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    let categories = ["Адміністративні послуги", "Містобудування та інфраструктура", "Соціальний захист", "Житловокомунальне господарство", "Юридична консультація", "Транспорт і зв'язок"]
    
    @IBAction func attachPhotoTapped(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func sendTapped(sender: AnyObject) {
        let thirdVC = self.storyboard?.instantiateViewControllerWithIdentifier("ThirdVC")
        self.navigationController?.pushViewController(thirdVC!, animated: true)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return categories[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Yfof", style:  .Plain, target: nil, action: nil)
        imagePicker.delegate = self
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
    
    
}
