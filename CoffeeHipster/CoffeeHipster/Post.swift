//
//  Post.swift
//  
//
//  Created by Dan Beaulieu on 5/10/16.
//
//

import Foundation
import CoreData


public final class Post: ManagedObject {
    
    @NSManaged var acceptedAnswerId: NSNumber?
    @NSManaged var answerCount: NSNumber
    @NSManaged var creationDate: NSDate
    @NSManaged var isAnswered: NSNumber
    @NSManaged var lastActivityDate: NSDate
    @NSManaged var link: NSURL
    @NSManaged var score: NSNumber
    @NSManaged var title: String
    @NSManaged var viewCount: NSNumber
    @NSManaged var tags: [NSString]
    @NSManaged var owner: User
    @NSManaged var questionId: NSNumber?
    
    public static func processBatch(moc: NSManagedObjectContext, posts: [AnyObject]) {
        let queue = dispatch_queue_create("mocQueue", DISPATCH_QUEUE_SERIAL)
        
        for post in posts {
            dispatch_sync(queue, { () in
                moc.performChanges {
                    Post.insertIntoContext(moc, json: post)
                }
            })
        }
    }
    
// Insert code here to add functionality to your managed object subclass
    public static func insertIntoContext(moc: NSManagedObjectContext, json: AnyObject) -> Post {
        print("\n==============\n Post: \n\(json) \n==============\n")
        let post: Post = moc.insertObject()
        
        var tags = [NSString]()
        
        //guard let accepted = json["accepted_answer_id"] as? Int else { fatalError("post: accepted failed") }
        guard let ansCount = json["answer_count"] as? Int else { fatalError("post: ansCount failed") }
        guard let created = json["creation_date"] as? String else { fatalError("post: created failed") }
        guard let answered = json["is_answered"] as? Int else { fatalError("post: answered failed") }
        guard let lastActive = json["last_activity_date"] as? String else { fatalError("post: lastActive failed") }
        guard let link = json["link"] as? NSURL else { fatalError("post: link failed") }
        guard let user = json["owner"]! else { fatalError("post: user failed") }
        guard let questId = json["question_id"] as? Int else { fatalError("post: questId failed") }
        guard let score = json["score"] as? Int else { fatalError("post: score failed") }
        guard let tagsGlob = json["tags"] as? [String] else { fatalError("post: tagsGlob failed") }
        guard let title = json["title"] as? String else { fatalError("post: title failed") }
        guard let count = json["view_count"] as? Int else { fatalError("post: somcountething failed") }  
        
        let owner = User.insertIntoContext(moc, json: user)
        
        dispatch_async(BackgroundQueue, {
            owner.managedObjectContext?.performChanges {
                User.insertIntoContext(moc, json: post)
            }
        })
        
        tagsGlob.forEach { tag in
            tags.append(tag)
        }

        //post.acceptedAnswerId = accepted
        post.answerCount = ansCount
        if let createdOn = NSDate(jsonDate:created) {
            post.creationDate = createdOn
        } else {
            post.creationDate = NSDate()
        }
        
        post.isAnswered = answered
    
        if let lastActiveOn = NSDate(jsonDate:lastActive) {
            post.lastActivityDate = lastActiveOn
        } else {
            post.lastActivityDate = NSDate()
        }
        
        post.link = link
        post.owner = owner
        post.tags = tagsGlob
        post.questionId = questId
        post.score = score
        post.title = title
        post.viewCount = count
        
        return post
    }
    
}



extension Post: ManagedObjectType {
    
    public static var entityName: String {
        return "Post"
    }
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "creationDate", ascending: false)]
    }
   
}
