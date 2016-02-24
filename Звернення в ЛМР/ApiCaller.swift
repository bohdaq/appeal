//
//  ApiCaller.swift
//  Звернення в ЛМР
//
//  Created by Prodeus Roman		 on 2/17/16.
//  Copyright © 2016 Bogdan Tsap. All rights reserved.
//

import UIKit
import SwiftyJSON

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
    
    static private let JSONStatusKey = "status"
    
    static private let OKStatusCode = 200
    
    static let user = User.sharedInstance
    static let appeal = Appeal.sharedInstance
    
    
    
    static func login(onSuccessCallback: () -> Void, onErrorCallback: () -> Void){
        
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: NSURL(string: loginUrl)!)
        request.HTTPMethod = "POST"
        
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        
        
        let dataString = emailKey + "=" + user.email + "&" + passwordKey + "=" + user.email + "&" + nameKey + "=" + user.name + "&" + addressKey + "=" + user.address + "&" + phoneKey + "=" + user.phone
        
        let data = dataString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.uploadTaskWithRequest(request, fromData: data, completionHandler:{(data, response, error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                onErrorCallback()
                return
            }
            
            let response = response as! NSHTTPURLResponse
            let statusCode = response.statusCode
            
            // to work with json with SwifyJSON you must convert NSData to string and then back to NSData
            let dataFromString = String(data: data!, encoding: NSUTF8StringEncoding)!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            let jsonData = JSON(data: dataFromString!)
            
            if statusCode == OKStatusCode && jsonData[JSONStatusKey].boolValue {
                onSuccessCallback()
                return
            }
            
            onErrorCallback()
            
        });
        
        task.resume()
        
        
    }
    
    static func sendAppeal(onSuccessCallback: () -> Void, onErrorCallback: () -> Void) {
        
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
            requestData.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        requestData.appendData("\(endBoundary)".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        let content:String = "multipart/form-data; beginBoundary=\(boundary)"
        request.setValue(content, forHTTPHeaderField: "Content-Type")
        request.setValue("\(requestData.length)", forHTTPHeaderField: "Content-Length")
        request.HTTPBody = requestData
        
        let task = session.uploadTaskWithRequest(request, fromData: nil, completionHandler: {(data, response, error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                onErrorCallback()
                return
            }
            
            let response = response as! NSHTTPURLResponse
            let statusCode = response.statusCode
            
            // to work with json with SwifyJSON you must convert NSData to string and then back to NSData
            let dataFromString = String(data: data!, encoding: NSUTF8StringEncoding)!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            let jsonData = JSON(data: dataFromString!)
            
            if statusCode == OKStatusCode && jsonData[JSONStatusKey].boolValue {
                onSuccessCallback()
                return
            }
            
            onErrorCallback()
            
        })
        
        task.resume()
    }
}