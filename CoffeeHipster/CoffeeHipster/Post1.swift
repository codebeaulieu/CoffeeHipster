//
//  Post.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 3/15/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

struct Post1 {
    var acceptedAnswerId : Int
    var answerCount : Int
    var creationDate : Int
    var isAnswered : Bool
    var lastActivityDate : Int
    var link : String
    var owner : UserObj
    var tags : Set<String>
    var questionId : Int
    var score : Int
    var title : String
    var viewCount : Int 

    init?(_ json : AnyObject) {

        guard let accepted = json["accepted_answer_id"] as? Int,
            let ansCount = json["answer_count"] as? Int,
            let created = json["creation_date"] as? Int,
            let answered = json["is_answered"] as? Bool,
            let lastActive = json["last_activity_date"] as? Int,
            let link = json["link"] as? String,
            let user = json["owner"],
            let questId = json["question_id"] as? Int,
            let score = json["score"] as? Int,
            let tagsGlob = json["tags"] as? [String],
            let title = json["title"] as? String,
            let count = json["view_count"] as? Int
        else { return nil }
        
        guard let owner = UserObj(user!) else { return nil }
        
        var tagSet = Set<String>()
        
        for tag in tagsGlob {
            tagSet.insert(tag)
        }
        
        
        self.acceptedAnswerId = accepted
        self.answerCount = ansCount
        self.creationDate = created
        self.isAnswered = answered
        self.lastActivityDate = lastActive
        self.link = link
        self.owner = owner
        self.tags = tagSet
        self.questionId = questId
        self.score = score
        self.title = title
        self.viewCount = count
         
    }
}