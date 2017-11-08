//
//  News+CoreDataProperties.swift
//  TestReignDesign
//
//  Created by Mauricio Figueroa olivares on 08-11-17.
//  Copyright © 2017 Maurix. All rights reserved.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var storyId: Int64
    @NSManaged public var storyTitle: String?
    @NSManaged public var author: String?
    @NSManaged public var storyLink: String?
    @NSManaged public var createdAt: String?

}
