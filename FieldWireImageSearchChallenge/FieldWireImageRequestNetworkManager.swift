//
//  FieldWireImageRequestNetworkManager.swift
//  FieldWireImageSearchChallenge
//
//  Created by Maxwell Elliott on 10/21/15.
//  Copyright © 2015 MLE. All rights reserved.
//

import Foundation
import AFNetworking

class FieldWireImageRequestNetworkManager {    
    class func fetchImagesFromImgurWithSearchString(searchString: String, page: Int, completionBlock:(() -> Void)) {
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfiguration.timeoutIntervalForRequest = 5
        let sessionManager = AFHTTPSessionManager(sessionConfiguration: sessionConfiguration)
        sessionManager.responseSerializer.acceptableContentTypes = Set.init(arrayLiteral: "application/json")
        sessionManager.requestSerializer.setValue("Client-ID c5b18950b0f2938", forHTTPHeaderField: "Authorization")
        sessionManager.GET("https://api.imgur.com/3/gallery/search/viral", parameters: ["q": searchString, "page": page], success: { (dataTask, responseData) -> Void in
            FieldWireImagePersistenceManager.saveImageDataFromImgur(searchString, responseData: responseData as! NSDictionary, completionBlock: { () -> Void in
                completionBlock()
            })
            }) { (dataTask, error) -> Void in
                // Handle this
                  completionBlock()
                print(error)
        }
        
//        sessionManager.GET(cardDataUrlString, parameters: nil, success: { [weak self] (operation, responseData) -> Void in
//            self?.dataManager?.loadCardDataFromResponseData(responseData as! NSData)
//            successBlock()
//            }) { (operation, error) -> Void in
//                failureBlock(error: error)
//        }
    }
}