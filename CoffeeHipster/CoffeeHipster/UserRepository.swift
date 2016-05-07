//
//  UserRepository.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 4/24/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

class UserRepository {
    
    class func manager(user : User, operation: Operation, completion: (status: Either) -> ()) {
        
        func get() {
            print("Getting user: \(user) \n")
            
        }
        
        func post() {
            print("Creating user: \(user) \n")
            
        }
        
        func put() {
            print("Updating user: \(user) \n")
            
        }
        
        func delete() {
            print("Deleting user: \(user) \n")
           
        }
        
        switch operation {
        case .GetUsers(let id):
            get()
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