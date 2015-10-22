//
//  FieldWireImagePersistenceManager.swift
//  FieldWireImageSearchChallenge
//
//  Created by Maxwell Elliott on 10/21/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import Foundation
import MagicalRecord

class FieldWireImagePersistenceManager {
    class func saveImageDataFromImgur(searchTerm: String, responseData: NSDictionary, completionBlock:(() -> Void)) {
        let imagesData = responseData["data"] as! NSArray
        MagicalRecord.saveWithBlock({ (context) -> Void in
        for imageData in imagesData as! [NSDictionary] {
            if (Image.MR_findFirstByAttribute("id", withValue: imageData["id"]) == nil) {
                let regexMatches = matchesForRegexInText("\\.\\w+$", text: imageData["link"] as! String)
                if regexMatches.count == 1 {
                    let image = Image.MR_createEntityInContext(context)
                    image.title = imageData["title"] as! String
                    image.link = imageData["link"] as! String
                    image.id = imageData["id"] as! String
                    image.search_term = searchTerm
                }
            }
            }}, completion: { (success, error) -> Void in
                completionBlock()
        })
    }
}