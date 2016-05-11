//
//  Post+CoreDataProperties.swift
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

extension Post {

    @NSManaged public private(set) var acceptedAnswerId: NSNumber
    @NSManaged public private(set) var answerCount: NSNumber
    @NSManaged public private(set) var creationDate: NSDate
    @NSManaged public private(set) var isAnswered: NSNumber
    @NSManaged public private(set) var lastActivityDate: NSDate
    @NSManaged public private(set) var link: NSURL
    @NSManaged public private(set) var score: NSNumber
    @NSManaged public private(set) var title: String
    @NSManaged public private(set) var viewCount: NSNumber
    @NSManaged public private(set) var tags: NSOrderedSet
    @NSManaged public private(set) var owner: User

}
