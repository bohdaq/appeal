//
//  ApiCaller.swift
//  Звернення в ЛМР
//
//  Created by Prodeus Roman		 on 2/17/16.
//  Copyright © 2016 Bogdan Tsap. All rights reserved.
//

import UIKit

class ApiCaller {
    
    static private let loginUrl = "http://testing.zvernennya.com.ua/service/user/signup?app_platform=iOS&amp;app_version=1"
    
    static private let sendAppealUrl = "http://testing.zvernennya.com.ua/service/appeal/create?app_platform=iOS&amp;app_version=1%22"
    
    static private let nameKey = "name"
    static private let emailKey = "email"
    static private let passwordKey = "password"
    static private let addressKey = "address"
    static private let phoneKey = "phone"
    
    static private let categoryKey = "category_id"
    static private let descriptionKey = "description"
    static private let isVisibleKey = "visible"
    static private let dateKey = "created_at"
    static private let locationKey = "location"
    
    static let user = User.sharedInstance
    static let appeal = Appeal.sharedInstance
    
    
    
    static func login(completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void){
        
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: NSURL(string: loginUrl)!)
        request.HTTPMethod = "POST"
        
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        
        
        let dataString = emailKey + "=" + user.email + "&" + passwordKey + "=" + user.email + "&" + nameKey + "=" + user.name + "&" + addressKey + "=" + user.address + "&" + phoneKey + "=" + user.phone
        
        let data = dataString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.uploadTaskWithRequest(request, fromData: data, completionHandler:completionHandler);
        
        task.resume()
        
        
    }
    
    static func sendAppeal(completionHandler: (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void){
        
        let session = NSURLSession.sharedSession()

        
        let boundary = "-BOUNDARY---RANDOM---BOUNDARY-"
        let beginBoundary = "--\(boundary)"
        let endBoundary = "--\(boundary)--"
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: sendAppealUrl)!)
        request.HTTPMethod = "POST"
        
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let body:NSMutableString = NSMutableString()
        
        body.appendFormat("\(beginBoundary)\r\n")
        body.appendFormat("Content-Disposition: form-data; name=\"\(categoryKey)\"\r\n\r\n")
        body.appendFormat("\(appeal.categoryId)\r\n")
        
        body.appendFormat("\(beginBoundary)\r\n")
        body.appendFormat("Content-Disposition: form-data; name=\"\(descriptionKey)\"\r\n\r\n")
        body.appendFormat("\(appeal.description)\r\n")
        
        body.appendFormat("\(beginBoundary)\r\n")
        body.appendFormat("Content-Disposition: form-data; name=\"\(isVisibleKey)\"\r\n\r\n")
        body.appendFormat("\(Int(appeal.isPublic))\r\n")
        
        body.appendFormat("\(beginBoundary)\r\n")
        body.appendFormat("Content-Disposition: form-data; name=\"\(dateKey)\"\r\n\r\n")
        body.appendFormat("\(Int(appeal.date))\r\n")
        
        if appeal.location != nil {
            body.appendFormat("\(beginBoundary)\r\n")
            body.appendFormat("Content-Disposition: form-data; name=\"\(locationKey)\"\r\n\r\n")
            body.appendFormat("\(appeal.location)")
        }
        
        
        
        let requestData:NSMutableData = NSMutableData()
        
        if appeal.image != nil {
            body.appendFormat("\(beginBoundary)\r\n")
            body.appendFormat("Content-Disposition: form-data; name=\"file\"; filename=\"picture.jpg\"\r\n")
            body.appendFormat("Content-Type: image/png\r\n")
            body.appendFormat("Content-Transfer-Encoding: binary\r\n\r\n")
            
            
            
            
        }
        
        requestData.appendData(body.dataUsingEncoding(NSUTF8StringEncoding)!)
        
        if appeal.image != nil {
            requestData.appendData(UIImagePNGRepresentation(appeal.image!)!)
        }
        requestData.appendData("\r\n\(endBoundary)".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        let content:String = "multipart/form-data; beginBoundary=\(boundary)"
        request.setValue(content, forHTTPHeaderField: "Content-Type")
        request.setValue("\(requestData.length)", forHTTPHeaderField: "Content-Length")
        request.HTTPBody = requestData
        
        let task = session.uploadTaskWithRequest(request, fromData: nil, completionHandler: completionHandler);
        
        task.resume()
    }
}