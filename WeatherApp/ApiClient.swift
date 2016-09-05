//
//  ApiClient.swift
//  WeatherApp
//
//  Created by Claudio Carnino on 05/09/2016.
//  Copyright © 2016 Tugulab. All rights reserved.
//

import Foundation


// It should not be subclassed
final class ApiClient {
    
    /// Api request result
    enum Result {
        case Success(ApiResponse)
        case Failure(ErrorType?)
    }
    
    enum Method {
        case GET
        // Future POST, PUT, DELETE
    }
    
    /// Api key
    let apiKey: String
    
    /// Base url of the backend
    let baseURL: NSURL
    
    
    /// Initialize
    init(apiKey: String, baseURL: NSURL) {
        self.apiKey = apiKey
        self.baseURL = baseURL
    }
    
    
    /// Add and process an api request
    func addRequest(request: ApiRequest, completion: (Result -> Void)) {
        
        // Note: In a real application, we would have a NSOperationQueue to which we append the request (which would wrapped inside a NSOperation).
        // The operation then would be processed depending the rules and priorities we set on the queue and its operations
        // Now we just execute the the operation using GCD, to keep things simpler, since setting up NSOperationsQueue takes a bit more.
        
        let backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
        dispatch_async(backgroundQueue) { 
            
            // Perform the request
            let result: Result = Result.Failure(nil)
            
            // Call completion on the main thread
            dispatch_async(dispatch_get_main_queue(), {
                completion(result)
            })
        }

    }
    
}
