//
//  User.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 3/15/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

struct UserObj {
    let userId : Int
    let displayName : String
    let profile : String
    let image : String
    let rep : Int
    let userType : String
    var hipsterRep : Int = 0

    init?(_ json : AnyObject) {
    
        guard let uId = json["user_id"] as? Int,
            let name = json["display_name"] as? String,
            let url = json["link"] as? String,
            let img = json["profile_image"] as? String,
            let repu = json["reputation"] as? Int,
            let type = json["user_type"] as? String
        else { return nil }
        
        self.userId = uId
        self.displayName = name
        self.profile = url
        self.image = img
        self.rep = repu
        self.userType = type

    }
}