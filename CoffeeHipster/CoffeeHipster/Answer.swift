//
//  Answer.swift
//  
//
//  Created by Dan Beaulieu on 5/27/16.
//
//

import Foundation
import CoreData


public final class Answer: ManagedObject {
 
    @NSManaged public private(set) var answer_id: NSNumber
    @NSManaged public private(set) var last_activity_date: NSDate
    @NSManaged public private(set) var creation_date: NSDate
    @NSManaged public private(set) var is_accepted: NSNumber
    @NSManaged public private(set) var body: String
    @NSManaged public private(set) var question_id: NSNumber
    @NSManaged public private(set) var score: NSNumber
    @NSManaged public private(set) var owner: User
    @NSManaged public private(set) var question: Post
    @NSManaged public private(set) var comments: Set<Comment>?
    
    public static func returnSet(moc: NSManagedObjectContext, jsonArray: [AnyObject]) -> Set<Answer> {
        var answers = Set<Answer>()

        for answer in jsonArray {
            answers.insert(Answer.insertIntoContext(moc, json: answer))
        }
        
        return answers
    }
    
    public static func insertIntoContext(moc: NSManagedObjectContext, json: AnyObject) -> Answer {
        guard let jsonAnswerId = json["answer_id"] as? Int else { fatalError("post: ansCount failed") }
        guard let jsonLastActivityDate = json["last_activity_date"] as? Int else { fatalError("post: created failed") }
        guard let jsonCreationDate = json["creation_date"] as? Int else { fatalError("post: answered failed") }
        guard let jsonIsAccepted = json["is_accepted"] as? Int else { fatalError("post: lastActive failed") }
        guard let jsonBody = json["body"] as? String else { fatalError("post: link failed") }
        guard let jsonQuestionId = json["question_id"] as? Int else { fatalError("post: user failed") }
        guard let jsonScore = json["score"] as? Int else { fatalError("post: link failed") }
        guard let jsonOwner = json["owner"]! else { fatalError("post: failed to unwrap user") }
        guard let jsonCommentCount = json["comment_count"] as? Int else { fatalError("derp") }
        
        let user = User.insertIntoContext(moc, json: jsonOwner)
        
        let created : NSDate = NSDate(timeIntervalSince1970: NSTimeInterval(jsonCreationDate))
        let lastActive : NSDate = NSDate(timeIntervalSince1970: NSTimeInterval(jsonLastActivityDate))
        
        let answer : Answer = moc.insertObject()
        answer.answer_id = jsonAnswerId
        answer.last_activity_date = lastActive
        answer.creation_date = created
        answer.body = jsonBody
        answer.is_accepted = jsonIsAccepted
        answer.score = jsonScore
        answer.question_id = jsonQuestionId
        answer.owner = user
        
        if jsonCommentCount > 0 {
            guard let jsonComments = json["comments"] as? [AnyObject] else { fatalError("post: failed to unwrap user") }
            let comments = Comment.returnSet(moc, jsonArray: jsonComments)
            answer.comments = comments
        }

        return answer
    }
    
}

extension Answer: ManagedObjectType {
    
    public static var entityName: String {
        return "Answer"
    }
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "creation_date", ascending: false)]
    }
    
}