//
//  PostRepository.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 4/24/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation
import Alamofire

enum Either {
    case Status(StatusCode)
    case Object([Post])
}

class PostRepository {
    class func manager(post : Post? = nil, operation: Operation, completion: (status: Either) -> Void) {
      
        func get(id : Int = 0) {
            
                Alamofire.request(.GET, "https://api.stackexchange.com/2.2/questions?order=desc&min=10&sort=activity&site=coffee")
                    .responseJSON { response in
                        
                        var posts = [Post]()
                        if let JSON = response.result.value {
                            if let jsonArray = JSON["items"] as? [[String: AnyObject]]  {
                                for item in jsonArray {
                                    guard let post = Post(item) else { continue }
                                    posts.append(post)
                                }
                                completion(status: Either.Object(posts))
                            }
                        }
                }
         
        }
        
        func post() {
            print("Creating user: \(post) \n")
            //completion(status: .Created)
        }
        
        func put() {
            print("Updating user: \(post) \n")
            //completion(status: .Ok)
        }
        
        func delete() {
            print("Deleting user: \(post) \n")
            //completion(status: .Ok)
        }
        
        switch operation {
        case .GetPosts(let id):
            print("id : \(id)")
            get(id)
        case .Post:
            post()
        case .Put:
            put()
        case .Delete:
            delete()
        default:
            assertionFailure()
        }
    }
}

