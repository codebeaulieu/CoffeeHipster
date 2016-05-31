//
//  Post.swift
//  
//
//  Created by Dan Beaulieu on 5/10/16.
//
//

import Foundation
import CoreData


public final class Post: ManagedObject, ManagedObjectOperations {
    
    @NSManaged public private(set) var acceptedAnswerId: NSNumber?
    @NSManaged public private(set) var answerCount: NSNumber
    @NSManaged public private(set) var creationDate: NSDate
    @NSManaged public private(set) var isAnswered: NSNumber
    @NSManaged public private(set) var lastActivityDate: NSDate
    @NSManaged public private(set) var link: NSURL
    @NSManaged public private(set) var score: NSNumber
    @NSManaged public private(set) var title: String
    @NSManaged public private(set) var viewCount: NSNumber
    @NSManaged public private(set) var tags: [NSString]
    @NSManaged public private(set) var owner: User
    @NSManaged public private(set) var questionId: NSNumber?
    @NSManaged public private(set) var body: String?
    @NSManaged public private(set) var downVoteCount: NSNumber
    @NSManaged public private(set) var upVoteCount: NSNumber
    @NSManaged public private(set) var answer: Set<Answer>?
    
    lazy public private(set) var currentVoteCount : Int = self.getCurrentVoteTotal()
    
    public static func processBatch(moc: NSManagedObjectContext, jsonArray: [AnyObject]) {
        let queue = dispatch_queue_create("postQueue", DISPATCH_QUEUE_SERIAL)
        
        var popped = jsonArray
        popped.removeLast()
        
        for post in popped {
            dispatch_sync(queue, { () in
                moc.performChanges {
                    //print("\n==============\n Post: \n\(post) \n==============\n")
                    Post.insertIntoContext(moc, json: post)
                }
            })
        }
    }
    
    func getCurrentVoteTotal() -> Int {
        return (upVoteCount as Int) - (downVoteCount as Int)
    }
    
    // Insert code here to add functionality to your managed object subclass
    public static func insertIntoContext(moc: NSManagedObjectContext, json: AnyObject) {
        //print("\n==============\n Post: \n\(json) \n==============\n")
        let post: Post = moc.insertObject()
        
        var tags = [NSString]()
        
        //guard let accepted = json["accepted_answer_id"] as? Int else { fatalError("post: accepted failed") }
        guard let ansCount = json["answer_count"] as? Int else { fatalError("post: ansCount failed") }
        guard let created = json["creation_date"] as? Int else { fatalError("post: created failed") }
        guard let answered = json["is_answered"] as? Int else { fatalError("post: answered failed") }
        guard let lastActive = json["last_activity_date"] as? Int else { fatalError("post: lastActive failed") }
        guard let link = json["link"] as? String else { fatalError("post: link failed") }
        guard let user = json["owner"]! else { fatalError("post: user failed") }
        guard let questId = json["question_id"] as? Int else { fatalError("post: questId failed") }
        guard let score = json["score"] as? Int else { fatalError("post: score failed") }
        guard let tagsGlob = json["tags"] as? [String] else { fatalError("post: tagsGlob failed") }
        guard let title = json["title"] as? String else { fatalError("post: title failed") }
        guard let count = json["view_count"] as? Int else { fatalError("post: somcountething failed") }
        guard let jsonQuestionId = json["question_id"] as? Int else { fatalError("post: created failed") }
        guard let jsonBody = json["body"] as? String else { fatalError("post: created failed") }
        guard let jsonDownVoteCount = json["down_vote_count"] as? Int else { fatalError("post: created failed") }
        guard let jsonUpVoteCount = json["up_vote_count"] as? Int else { fatalError("post: created failed") }
        
        
        let owner = User.insertIntoContext(moc, json: user)
        
        var answerSet : Set<Answer>?
        
        if let jsonAnswers = json["answers"] as? [AnyObject] {
            answerSet = Answer.returnSet(moc, jsonArray: jsonAnswers)
        }
    
        let date : NSDate = NSDate(timeIntervalSince1970: NSTimeInterval(created))
        let last : NSDate = NSDate(timeIntervalSince1970: NSTimeInterval(lastActive))
 
        tagsGlob.forEach { tag in
            tags.append(tag)
        }
        
        //post.acceptedAnswerId = accepted
        post.answerCount = ansCount
        post.creationDate = date
        post.isAnswered = answered
        post.lastActivityDate = last
        post.link =  NSURL(fileURLWithPath: link)
        post.owner = owner
        post.tags = tagsGlob
        post.questionId = questId
        post.score = score
        post.title = title
        post.viewCount = count
        post.questionId = jsonQuestionId
        post.body = jsonBody
        post.downVoteCount = jsonDownVoteCount
        post.upVoteCount = jsonUpVoteCount
        post.answer = answerSet
        post.owner = owner

        
        moc.performChanges {
            post
        }
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
