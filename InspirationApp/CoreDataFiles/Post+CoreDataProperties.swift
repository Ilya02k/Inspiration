//
//  Post+CoreDataProperties.swift
//  InspirationApp
//
//  Created by Илья Козлов on 10/12/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//
//

import Foundation
import CoreData


extension Post {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        let request: NSFetchRequest<Post> = NSFetchRequest<Post>(entityName: "Post")
        let array = NSArray(object: NSSortDescriptor(key: "self", ascending: true))
        //array.adding(NSSortDescriptor(key: "self", ascending: true))
        request.sortDescriptors = array as? [NSSortDescriptor]
        return request
    }

    @NSManaged public var imagePostURL: String?
    @NSManaged public var isFavorite: String?

}
