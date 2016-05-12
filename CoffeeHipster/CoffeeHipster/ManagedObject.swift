//
//  ManagedObject.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/10/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import UIKit
import CoreData

public class ManagedObject: NSManagedObject {

}

public protocol ManagedObjectType: class {
    static var entityName: String { get }
    static var defaultSortDescriptors:[NSSortDescriptor] { get }
}

extension ManagedObjectType {
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
    
    public static var sortedFetchRequest:NSFetchRequest {
        let request = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
    
    public static func batchUpdate() {
        
    }
}