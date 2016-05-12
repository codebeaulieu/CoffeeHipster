//
//  Extension+NSManagedObjectContext.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/11/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    public func insertObject<A: ManagedObject where A: ManagedObjectType>() -> A {
        guard let obj = NSEntityDescription.insertNewObjectForEntityForName(A.entityName, inManagedObjectContext: self) as? A
            else { fatalError("Wrong object type") }
        return obj
    }
}
//TODO: re-evaluate
//extension Array where Element : NSManagedObjectContext {
//    public func performBatchChanges(update: Element -> Element) {
//        for item in self {
//            item.performChanges {
//                
//            }
//        }
//        
//    }
//}

extension NSManagedObjectContext {

    public func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }

    public func performChanges(block: () -> ()) {
        performBlock {
            block()
            self.saveOrRollback()
        }
    }
    
}
