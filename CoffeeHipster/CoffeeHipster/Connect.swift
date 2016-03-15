//
//  Connect.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 3/15/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation
import Alamofire

class Connect {
    
    class func getPosts(completion:([Post]) -> Void) {
        
        
        Alamofire.request(.GET, "https://api.stackexchange.com/2.2/questions?order=desc&min=10&sort=activity&site=coffee")
            .responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization
                var posts = [Post]()
                if let JSON = response.result.value {
                    if let jsonArray = JSON["items"] as? [[String: AnyObject]]  {
                        for item in jsonArray {
                            guard let post = Post(item) else { continue }
                            posts.append(post)
                        }
                        completion(posts)
                    }
                }
        }
    }
}