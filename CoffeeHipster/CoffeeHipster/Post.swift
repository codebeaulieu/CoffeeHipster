//
//  Post.swift
//  
//
//  Created by Dan Beaulieu on 5/10/16.
//
//

import Foundation
import CoreData


public final class Post: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    init?(_ json : AnyObject) {
        
        guard let accepted = json["accepted_answer_id"] as? Int,
            let ansCount = json["answer_count"] as? Int,
            let created = json["creation_date"] as? NSDate,
            let answered = json["is_answered"] as? Int,
            let lastActive = json["last_activity_date"] as? NSDate,
            let link = json["link"] as? NSURL,
            let user = json["owner"],
            let questId = json["question_id"] as? Int,
            let score = json["score"] as? Int,
            let tagsGlob = json["tags"] as? [String],
            let title = json["title"] as? String,
            let count = json["view_count"] as? Int
            else { return nil }
        
        guard let owner = User(user!) else { return nil }
        
        guard let tags = Tag1(tagsGlob) else { return nil }
        
        
        self.acceptedAnswerId = accepted
        self.answerCount = ansCount
        self.creationDate = created
        self.isAnswered = answered
        self.lastActivityDate = lastActive
        self.link = link
        self.owner = owner
        self.tags = tags
        self.questionId = questId
        self.score = score
        self.title = title
        self.viewCount = count
        
    }
}
