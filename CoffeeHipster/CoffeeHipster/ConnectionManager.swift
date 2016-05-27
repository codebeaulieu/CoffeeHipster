//
//  Connect.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 3/15/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation
import CoreData

final class Connect {
    
    class func handle(obj : AnyObject? = nil, repo repository: Repo, _ operation: Operation, completion: (Either -> Void)) {
        
        switch repository {
        case .Post:
            PostRepository.manager(obj as? Post, operation: operation) { either in
                completion(either)
            }
        case .User:
            UserRepository.manager(obj as? User, operation: operation) { either in
                completion(either)
            }
        case .Wiki:
            WikiRepository.manager(obj as? User, operation: operation) { either in
                completion(either)
            }
        case .Stat:
            StatRepository.manager(obj as? User, operation: operation) { either in
                completion(either)
            }
        } 
    }
}

