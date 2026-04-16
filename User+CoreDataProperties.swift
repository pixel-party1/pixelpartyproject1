//
//  User+CoreDataProperties.swift
//  pixel party
//
//  Created by Roome, Ellis on 15/04/2026.
//
//

public import Foundation
public import CoreData


public typealias UserCoreDataPropertiesSet = NSSet

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var username: String?
    @NSManaged public var hashedPassword: String?

}

extension User : Identifiable {

}
