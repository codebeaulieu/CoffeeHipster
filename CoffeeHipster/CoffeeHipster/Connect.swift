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
    
    class func handle(obj : AnyObject? = nil, repo repository: Repo, _ operation: Operation, completion: (result: Either) -> Void) {
        
        switch repository {
        case .Post:
            PostRepository.manager(obj as? Post, operation: operation) { either in
                completion(result: either)
            }
        case .User:
            UserRepository.manager(obj as? User, operation: operation) { either in
                completion(result: either)
            }
            
        } 
    }
}

