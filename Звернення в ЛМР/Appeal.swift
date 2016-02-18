//
//  Appeal.swift
//  Звернення в ЛМР
//
//  Created by Prodeus Roman		 on 2/17/16.
//  Copyright © 2016 Bogdan Tsap. All rights reserved.
//

import UIKit

class Appeal{
    static let sharedInstance = Appeal()
    
    init (){}
    
    init (categoryId: Int, description: String, isPublic: Bool, date: Int, image: UIImage, location: String){
        self.categoryId = categoryId
        self.description = description
        self.isPublic = isPublic
        self.date = date
        self.image = image
        self.location = location
    }
    
    var categoryId: Int = 1
    var description: String = ""
    var isPublic: Bool = true
    var date: Int = 0
    var image: UIImage?
    var location: String?
}
