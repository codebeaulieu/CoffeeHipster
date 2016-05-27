//
//  PostRepository.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 4/24/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation
import Alamofire

final class PostRepository {
    class func manager(post : Post? = nil, operation: Operation, completion: (Either -> Void)) {
        //https://api.stackexchange.com/2.2/questions?order=desc&min=10&sort=activity&site=coffee
        func get(id : Int = 0) {
            Alamofire.request(.GET, "https://api.stackexchange.com/2.2/questions?order=desc&sort=activity&site=coffee&filter=!3yXvh9)gdfMXsQu4D")
                .responseJSON { response in
                    
                if response.result.isFailure { completion(Either.Status(StatusCode.Offline)); return }
                
                if let JSON = response.result.value {
                    if let jsonArray = JSON["items"] as? [[String: AnyObject]] {
                        print("jsonArray: \(jsonArray[1])")
                        completion(Either.Object(jsonArray))
                    }
                } else {
                    completion(Either.Status(StatusCode.RequestTimeOut))
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
            get(id)
        case .Post:
            post()
        case .Put:
            put()
        case .Delete:
            delete()
        }
    }
}

