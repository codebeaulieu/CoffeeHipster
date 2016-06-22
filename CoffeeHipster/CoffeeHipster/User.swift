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
    
    public static func saveToCoreData(moc: NSManagedObjectContext, json: AnyObject) {
        // TODO : this function should fetch or create
        let user = User.insertIntoContext(moc, json: json)
        
        moc.performChanges {
            user
        }
    }
    
    public static func insertIntoContext(moc: NSManagedObjectContext, json: AnyObject) -> User {
        
        let user: User = moc.insertObject()

        guard let name = json["display_name"] as? String,
            type = json["user_type"] as? String else { fatalError() }
        
        if type != "does_not_exist" {
            guard let userId = json["user_id"] as? Int,
                url = json["link"] as? String,
                image = json["profile_image"] as? String,
                rep = json["reputation"] as? Int
            else { fatalError("failed to extract user") }
            user.userId = userId ?? 0
            user.image = image ?? "TODO:// add no image pic"
            user.profile = NSURL(fileURLWithPath: url ?? "")
            user.rep = rep ?? 0
        }
        
        user.displayName = name ?? ""
        user.userType = type ?? ""

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