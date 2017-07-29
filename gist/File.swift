//
//  File.swift
//  gist
//
//  Created by Tega Esabunor on 27/7/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataRequest {
    
    let postEndPoint : String = "http://jsonplaceholder.typicode.com/posts/1"
    
    init() {
        guard let url = URL(string: postEndPoint) else {
            print("Error: cannot create url")
            return
        }
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest, completionHandler: handler)
        
        task.resume()
    }
    
    
    func handler(_ data: Data?,_ response: URLResponse?,_ error: Error?) -> Void {
        guard let responseData = data else {
            print("Error: did not receive data")
            return
        }
        
        guard error == nil else {
            //if false it gets here
            print("error calling GET on /posts/1")
            return
        }
        
        let post = JSON(data: responseData)
        
        
    }
    
}

class DataRequestPost {
    let postEndPoint : String = "http://jsonplaceholder.typicode.com/posts"
    
    init() {
        guard let url = URL(string: postEndPoint) else {
            print("Error: cannot create url")
            return
        }
        let urlRequest = NSMutableURLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let newPost: Dictionary<String, Any> = ["title": "Tega's post", "body": "i am first", "userId":1]
        
        do {
            let jsonPost = try JSONSerialization.data(withJSONObject: newPost, options: [])
            urlRequest.httpBody = jsonPost

        } catch {
            print("Error: cannot create json from post")
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: handler)
        
        task.resume()
    }
    
    
    func handler(_ data: Data?,_ response: URLResponse?,_ error: Error?) -> Void {
        guard let responseData = data else {
            print("Error: did not receive data")
            return
        }
        
        guard error == nil else {
            //if false it gets here
            print("error calling GET on /posts/1")
            return
        }
        
        let post: Dictionary<String, Any>
        do {
            post = try JSONSerialization.jsonObject(with: responseData, options: []) as! Dictionary
        } catch {
            print("error trying to convert data to JSON")
            return
        }
        
        print("The post is: " + post.description)
        
        
        if let postId = post["id"] as? Int {
            print("The title is: \(postId)")
        }
        
        
    }
}


class DataRequestCocoa {
    let postEndPoint : String = "http://jsonplaceholder.typicode.com/posts/1"
    init() {
        Alamofire.request(postEndPoint, method: .get).responseJSON {
            (response) -> Void in
            
            if let value = response.result.value {
                let json = JSON(value)
                print(json["title"].stringValue)
            }
            
        }
    }
}
