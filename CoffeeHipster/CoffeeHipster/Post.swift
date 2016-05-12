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
    
    
    
    @NSManaged var acceptedAnswerId: NSNumber
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
                post.managedObjectContext?.performChanges {
                    Post.insertIntoContext(moc, json: post)
                }
            })
        }
    }
    
// Insert code here to add functionality to your managed object subclass
    public static func insertIntoContext(moc: NSManagedObjectContext, json: AnyObject) -> Post {
        
        let post: Post = moc.insertObject()
        
        var tags = [NSString]()
        
        guard let accepted = json["accepted_answer_id"] as? Int,
            let ansCount = json["answer_count"] as? Int,
            let created = json["creation_date"] as? NSDate,
            let answered = json["is_answered"] as? Int,
            let lastActive = json["last_activity_date"] as? NSDate,
            let link = json["link"] as? NSURL,
            let user = json["owner"]!,
            let questId = json["question_id"] as? Int,
            let score = json["score"] as? Int,
            let tagsGlob = json["tags"] as? [String],
            let title = json["title"] as? String,
            let count = json["view_count"] as? Int
        else { return Post() }
        
        
        guard let owner = User.insertIntoContext(moc, json: user) else { fatalError("failed to associate user with post") }
        
        dispatch_async(BackgroundQueue, {
            owner.managedObjectContext?.performChanges {
                User.insertIntoContext(moc, json: post)
            }
        })
        
        tagsGlob.forEach { tag in
            tags.append(tag)
        }

        post.acceptedAnswerId = accepted
        post.answerCount = ansCount
        post.creationDate = created
        post.isAnswered = answered
        post.lastActivityDate = lastActive
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
