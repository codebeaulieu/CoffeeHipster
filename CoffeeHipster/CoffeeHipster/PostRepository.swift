//
//  PostRepository.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 4/24/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation
import Alamofire

final class PostConnect {
    class func manager(post : Post? = nil, operation: Operation, completion: (status: Either) -> Void) {
        //https://api.stackexchange.com/2.2/questions?order=desc&min=10&sort=activity&site=coffee
        func get(id : Int = 0) {
            
            // source: https://api.stackexchange.com/docs/posts#order=desc&sort=creation&filter=!2sTIRt2e4yt2ZIdhKEKN*E5vOnLaUD-kK4zszF0XTr&site=coffee&run=true
            // might -> : /2.2/questions?order=desc&sort=creation&site=coffee&filter=!53BrpFKIyYM9M4pIDMIoGd8FnO6*)u-Gx_w)6L
            // /2.2/posts?order=desc&sort=creation&site=coffee&filter=!2sTIRt2e4yt2ZIdhKEKN*E5vOnLaUD-kK4zszF0XTr
            
            Alamofire.request(.GET, "/2.2/questions?order=desc&sort=creation&site=coffee&filter=!53BrpFKIyYM9M4pIDMIoGd8FnO6*)u-Gx_w)6L-NO")
                .responseJSON { response in
                    
                if response.result.isFailure { completion(status: Either.Status(StatusCode.Offline)); return }
                
                if let JSON = response.result.value {
                    if let jsonArray = JSON["items"] as? [[String: AnyObject]] {
                        print("jsonArray: \(jsonArray[1])")
                        completion(status: Either.Object(jsonArray)); return
                    }
                } else {
                    completion(status: Either.Status(StatusCode.RequestTimeOut)); return
                }
            }
        }
        
        func getById(id : [Int]) {
            
            // build a string from the contents of the incoming array
            // semi-colon delimited list
            
            Alamofire.request(.GET, "https://api.stackexchange.com/2.2/posts/\(id)?order=desc&sort=activity&site=coffee&filter=!3yXvh7JDU)hU-ZHbm")
                .responseJSON { response in
                    
                    if response.result.isFailure { completion(status: Either.Status(StatusCode.Offline)); return }
                    
                    if let JSON = response.result.value {
                        if let jsonArray = JSON["items"] as? [[String: AnyObject]] {
                            print("jsonArray: \(jsonArray[1])")
                            completion(status: Either.Object(jsonArray)); return
                        }
                    } else {
                        completion(status: Either.Status(StatusCode.RequestTimeOut)); return
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
        case .Get:
            get()
        case .GetById(let id):
            getById(id)
        case .Post:
            post()
        case .Put:
            put()
        case .Delete:
            delete()
        }
    }
}

