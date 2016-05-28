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
    
    class func handle(obj : AnyObject? = nil, api repository: Remote, request operation: Operation, moc: NSManagedObjectContext) {
        // process
        func process<T: ManagedObject where T: ManagedObjectOperations>(object : T? = nil, result: Either) {
            
            switch result {
            case .Status(let code):
                print("status code: \(code)") // TODO: depending on the status code, possibly trigger a modal
            case .Object(let obj):
                if case .Get = operation {
                    guard let objects = obj as? [AnyObject] else { return }
                    T.processBatch(moc, jsonArray: objects)
                } else if case .GetById(_) = operation {
                    T.insertIntoContext(moc, json: obj)
                }
            }
        }
        
        switch repository {
        case .Post:
            PostConnect.manager(obj as? Post, operation: operation) { either in
                process(obj as? Post, result: either)
            }
        case .User:
            UserConnect.manager(obj as? User, operation: operation) { either in
                process(obj as? Post, result: either)
            }
        case .Wiki:
            WikiConnect.manager(obj as? User, operation: operation) { either in
                process(obj as? Post, result: either)
            }
        case .Stat:
            StatConnect.manager(obj as? User, operation: operation) { either in
                process(obj as? Post, result: either)
            }
        } 
    }
}

