//
//  UserRepository.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 4/24/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

final class UserConnect {
    
    class func manager(user : User? = nil, operation: Operation, completion: (status: Either) -> ()) {
        
        func get(id : Int = 0) {
            print("Getting user: \(user) \n")
            
        }
        func getById(id : [Int]) {
            
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