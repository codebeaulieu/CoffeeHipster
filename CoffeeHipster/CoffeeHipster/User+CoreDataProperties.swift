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

    @NSManaged var userId: NSNumber
    @NSManaged var displayName: String
    @NSManaged var profile: NSObject
    @NSManaged var image: String
    @NSManaged var rep: NSNumber
    @NSManaged var userType: String
    @NSManaged var hipsterRep: NSNumber
    @NSManaged var posts: NSOrderedSet

}
