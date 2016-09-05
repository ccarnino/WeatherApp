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
    
    enum Method: String {
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
            
            // Add the api key to the params
            var allParams = (request.params != nil) ? request.params! : [:]
            allParams["appid"] = self.apiKey
            
            let absoluteURL: NSURL
            switch request.method {
            case .GET:
                // Append the params to the URL
                let partialURL = self.baseURL.URLByAppendingPathComponent(request.endpoint)
                let urlComponents = NSURLComponents(string: partialURL.absoluteString)!
                urlComponents.queryItems = []
                for (key, value) in allParams {
                    let queryItem = NSURLQueryItem(name: key, value: "\(value)")
                    urlComponents.queryItems?.append(queryItem)
                }
                guard let urlComponentsURL = urlComponents.URL else {
                    // Call completion on the main thread
                    dispatch_async(dispatch_get_main_queue(), {
                        // Failed to parse the json response
                        completion(.Failure(nil))
                    })
                    return
                }
                absoluteURL = urlComponentsURL
                
//          Future case .POST:
//                absoluteURL = self.baseURL.URLByAppendingPathComponent(request.endpoint)
//                urlRequest.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
            }
            
            
            // Create the URL request with the informations we have
            let urlRequest = NSMutableURLRequest(URL: absoluteURL)
            urlRequest.allHTTPHeaderFields = request.headers
            urlRequest.HTTPMethod = request.method.rawValue
            
            // Perform the URL request
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(urlRequest, completionHandler: { data, response, error in
                
                // Evaluate the response of the request
                if let error = error {
                    print(error) // TODO: remove
                    
                    // Call completion on the main thread
                    dispatch_async(dispatch_get_main_queue(), {
                        // Failed to parse the json response
                        completion(.Failure(error))
                    })
                }
                
                guard let data = data,
                    let json = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
                    let jsonDictionary = json as? NSDictionary,
                    let apiResponse = try? request.responseWithJson(jsonDictionary) else {
                    // Call completion on the main thread
                    dispatch_async(dispatch_get_main_queue(), {
                        // Failed to parse the json response
                        completion(.Failure(nil))
                    })
                    return
                }
                
                print("Synchronous\(jsonDictionary)") // TODO: remove
                print(apiResponse)
                
                // Call completion on the main thread
                dispatch_async(dispatch_get_main_queue(), {
                    completion(.Success(apiResponse))
                })
            })
            
            task.resume()
        }

    }
    
}
