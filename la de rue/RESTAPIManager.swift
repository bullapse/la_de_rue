//
//  RESTAPIManager.swift
//  la de rue
//
//  Created by Spencer Bull on 7/11/15.
//  Copyright (c) 2015 bullapse. All rights reserved.
//

import Foundation

typealias ServiceResponce = (JSON, NSError?) -> Void

class RESTAPIManager: NSObject {
 
    static let sharedInstance = RESTAPIManager()
    
    var baseURL = "http://localhost:4730"
    
    func getTruckNames(OnCompletion: (JSON) -> Void) {
        makeHTTPGetRequest(baseURL, onCompletion: { json, err -> Void in
            OnCompletion(json)
        })
        
    }
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponce) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: { data, responce, error in
            let json:JSON = JSON(data: data)
            onCompletion(json, error)
    })
        task.resume()
    }
    
}