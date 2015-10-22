//
//  Image.swift
//  FieldWireImageSearchChallenge
//
//  Created by Maxwell Elliott on 10/21/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import Foundation
import CoreData
import MagicalRecord

class Image: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    func thumbnailURL() -> String {
        let regexMatches = matchesForRegexInText("\\.\\w+$", text: self.link!)
        if (regexMatches.count == 1) {
            if let fileExtension = regexMatches[0] as? String {
                var thumbnailString = String(stringLiteral: self.link!)
                let fileExtensionRange = thumbnailString.rangeOfString(fileExtension)
                thumbnailString.replaceRange(fileExtensionRange!, with: "s".stringByAppendingString(fileExtension))
                return thumbnailString
            }
        }
        return self.link!
    }
}
