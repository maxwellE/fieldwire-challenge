//
//  Image+CoreDataProperties.swift
//  FieldWireImageSearchChallenge
//
//  Created by Maxwell Elliott on 10/21/15.
//  Copyright © 2015 MLE. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData
import MagicalRecord

extension Image {

    @NSManaged var title: String?
    @NSManaged var link: String?
    @NSManaged var id: String?
    @NSManaged var search_term: String?

}
