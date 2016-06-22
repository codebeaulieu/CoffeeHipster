//
//  ManagedObjectContextSettable.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/10/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation
import CoreData

protocol ManagedObjectContextSettable: class {
    var moc: NSManagedObjectContext! { get set }
}

extension ManagedObjectContextSettable {
    func checkManagedObjectContext(name : String) {
        if moc == nil {
            assertionFailure("\(name) is missing the managed object context.")
        }
    }
}