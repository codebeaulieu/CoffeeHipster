//
//  ManagedObjectOperations.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/27/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation
import CoreData

protocol ManagedObjectOperations {
    static func insertIntoContext(moc: NSManagedObjectContext, json: AnyObject)
    static func processBatch(moc: NSManagedObjectContext, jsonArray: [AnyObject])
}