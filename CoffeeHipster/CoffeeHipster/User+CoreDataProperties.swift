//
//  User+CoreDataProperties.swift
//  
//
//  Created by Dan Beaulieu on 5/10/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged public private(set) var userId: NSNumber
    @NSManaged public private(set) var displayName: String
    @NSManaged public private(set) var profile: NSObject
    @NSManaged public private(set) var image: String
    @NSManaged public private(set) var rep: NSNumber
    @NSManaged public private(set) var userType: String
    @NSManaged public private(set) var hipsterRep: NSNumber
    @NSManaged public private(set) var posts: NSOrderedSet

}
