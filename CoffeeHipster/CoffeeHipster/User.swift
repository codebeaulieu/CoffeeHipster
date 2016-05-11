//
//  User.swift
//  
//
//  Created by Dan Beaulieu on 5/10/16.
//
//

import Foundation
import CoreData


public final class User: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
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
