//
//  Post+CoreDataProperties.swift
//  
//
//  Created by Dan Beaulieu on 5/27/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Post {

    @NSManaged var acceptedAnswerId: NSNumber?
    @NSManaged var answerCount: NSNumber?
    @NSManaged var body: String?
    @NSManaged var creationDate: NSDate?
    @NSManaged var isAnswered: NSNumber?
    @NSManaged var lastActivityDate: NSDate?
    @NSManaged var link: NSObject?
    @NSManaged var questionId: NSNumber?
    @NSManaged var score: NSNumber?
    @NSManaged var tags: NSObject?
    @NSManaged var title: String?
    @NSManaged var viewCount: NSNumber?
    @NSManaged var downVoteCount: NSNumber?
    @NSManaged var upVoteCount: NSNumber?
    @NSManaged var owner: User?
    @NSManaged var answer: NSSet?

}
