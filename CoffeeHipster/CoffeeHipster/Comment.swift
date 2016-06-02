//
//  Comment.swift
//  
//
//  Created by Dan Beaulieu on 6/2/16.
//
//

import Foundation
import CoreData


public final class Comment: ManagedObject {

    @NSManaged var body: String
    @NSManaged var comment_id: NSNumber
    @NSManaged var creation_date: NSDate
    @NSManaged var edited: NSNumber?
    @NSManaged var post_id: NSNumber
    @NSManaged var score: NSNumber?
    @NSManaged var owner: User

    public static func returnSet(moc: NSManagedObjectContext, jsonArray: [AnyObject]) -> Set<Comment> {
        var comments = Set<Comment>()
        
        for answer in jsonArray {
            comments.insert(Comment.insertIntoContext(moc, json: answer))
        }
        
        return comments
    }
    
    public static func insertIntoContext(moc: NSManagedObjectContext, json: AnyObject) -> Comment {
        //print("\ncomment : \n \(json)\n")
        guard let jsonBody = json["body"] as? String else { fatalError("post: ansCount failed") }
        guard let jsonCommentId = json["comment_id"] as? Int else { fatalError("post: created failed") }
        guard let jsonCreationDate = json["creation_date"] as? Int else { fatalError("post: answered failed") }
        guard let jsonEdited = json["edited"] as? Bool else { fatalError("post: lastActive failed") }
        guard let jsonOwner = json["owner"]! else { fatalError("post: link failed") }
        guard let jsonPostId = json["post_id"] as? Int else { fatalError("post: user failed") }
        guard let jsonScore = json["score"] as? Int else { fatalError("post: user failed") }
        
        let user = User.insertIntoContext(moc, json: jsonOwner)
        
        let created : NSDate = NSDate(timeIntervalSince1970: NSTimeInterval(jsonCreationDate))
        let comment : Comment = moc.insertObject() 
        comment.body = jsonBody
        comment.creation_date = created
        comment.body = jsonBody
        comment.edited = jsonEdited
        comment.score = jsonScore
        comment.post_id = jsonPostId
        comment.comment_id = jsonCommentId
        comment.owner = user

        return comment
    }    
}

extension Comment: ManagedObjectType {
    
    public static var entityName: String {
        return "Comment"
    }
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "comment_id", ascending: false)]
    }
    
}