//
//  Connect.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 3/15/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

final class Connect {
    private let userRepo = UserRepository()
    private let postRepo = PostRepository()
    
    class func handle(obj : AnyObject? = nil, operation: Operation, completion: (result: Either) -> Void) {

        func callUserRepo(user: User? = nil) {
            UserRepository.manager(user!, operation: operation) { either in
               
            }
        }
        
        func callPostsRepo(post: Post? = nil) {
            PostRepository.manager(post, operation: operation) { either in
                completion(result: either)
            }
        }
        
        if obj == nil {
            switch operation {
            case .GetUsers(_):
                callUserRepo()
            case .GetPosts(_):
                callPostsRepo()
            default:
                assertionFailure()
            }
        } else {
            if let user = obj as? User {
                callUserRepo(user)
            }
            
            if let post = obj as? Post {
                callPostsRepo(post) 
            }
        }
        
        
    }
}

