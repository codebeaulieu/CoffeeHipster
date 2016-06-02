//
//  PostRepository.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 4/24/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//
//
import Foundation
import Alamofire

final class PostConnect {
    class func manager(post : Post? = nil, operation: Operation, completion: (Either -> Void)) {

        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        func checkLatestPostId(result:(postId: Int)->Void){
            ///
            Alamofire.request(.GET, "2.2/posts?pagesize=1&order=desc&sort=creation&site=coffee&filter=!3tz1Wb9MFZsqZaa0.").responseJSON { response in
                    
                if response.result.isFailure { completion(Either.Status(StatusCode.Offline)); return }
                if let JSON = response.result.value {
                    print("result: \(JSON)")
                    
                    if let jsonArray = JSON["items"] as? [[String: AnyObject]] {
                        print("object count: \(jsonArray)")
                        
                    }
                }
            } 
        }
        
        func get(id : Int = 0) {

            let qty = userDefaults.valueForKey("first-run") as! Bool ? 40 : 10
            checkLatestPostId() { postId in
                print("post id: \(postId)")
            
                Alamofire.request(.GET, "https://api.stackexchange.com/2.2/questions?pagesize=\(qty)&order=desc&sort=activity&site=coffee&filter=!-MQ9xTmbG8fYGhjq4Rg1(IM7N1R.Zajm9")
                    .responseJSON { response in
       
                    if response.result.isFailure { completion(Either.Status(StatusCode.Offline)); return }
                    if let JSON = response.result.value {
                      
                        if let jsonArray = JSON["items"] as? [[String: AnyObject]] {
                            print("object count: \(jsonArray.count)")
                            completion(Either.Object(jsonArray)); return
                        }
                        
                    } else {
                        completion(Either.Status(StatusCode.RequestTimeOut)); return
                    }
                }
            }
        }
        
        func getById(id : [Int]) {
            
            // build a string from the contents of the incoming array
            // semi-colon delimited list
            
            Alamofire.request(.GET, "https://api.stackexchange.com/2.2/posts/\(id)?order=desc&sort=activity&site=coffee&filter=!3yXvh7JDU)hU-ZHbm")
                .responseJSON { response in
                    
                    if response.result.isFailure { completion(Either.Status(StatusCode.Offline)); return }
                    
                    if let JSON = response.result.value {
                        if let jsonArray = JSON["items"] as? [[String: AnyObject]] {
                            //print("jsonArray: \(jsonArray[1])")
                            completion(Either.Object(jsonArray)); return
                        }
                    } else {
                        completion(Either.Status(StatusCode.RequestTimeOut)); return
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

// docs: https://api.stackexchange.com/docs/posts#order=desc&sort=creation&filter=!2sTIRt2e4yt2ZIdhKEKN*E5vOnLaUD-kK4zszF0XTr&site=coffee&run=true
// old: 2.2/questions?order=desc&sort=creation&site=coffee&filter=!3yXvh452l.xgxAx7H
