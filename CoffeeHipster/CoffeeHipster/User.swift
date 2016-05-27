//
//  User.swift
//  
//
//  Created by Dan Beaulieu on 5/10/16.
//
//

import Foundation
import CoreData


public final class User: ManagedObject {

    @NSManaged var userId: NSNumber?
    @NSManaged var displayName: String
    @NSManaged var profile: NSURL?
    @NSManaged var image: String?
    @NSManaged var rep: NSNumber?
    @NSManaged var userType: String
    @NSManaged var hipsterRep: NSNumber?
    @NSManaged var posts: NSOrderedSet?
    
    
    public static func insertIntoContext(moc: NSManagedObjectContext, json: AnyObject) -> User {
        
        let user: User = moc.insertObject()
        
        let name = json["display_name"] as? String
        let type = json["user_type"] as? String
        let userId = json["user_id"] as? Int
        let url = json["link"] as? String
        let image = json["profile_image"] as? String
        let rep = json["reputation"] as? Int
        
        user.userId = userId ?? 0
        user.displayName = name ?? ""
        user.profile = NSURL(fileURLWithPath: url ?? "")
        user.image = image ?? "TODO:// add no image pic"
        user.rep = rep ?? 0
        user.userType = type ?? ""
        user.hipsterRep = 0
        // TODO: user posts stores all of the users postId's
        
        return user
    }
}

extension User: ManagedObjectType {
    
    public static var entityName: String {
        return "User"
    }
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "userId", ascending: false)]
    }
    
}