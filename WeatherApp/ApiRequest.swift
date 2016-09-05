//
//  ApiRequest.swift
//  WeatherApp
//
//  Created by Claudio Carnino on 05/09/2016.
//  Copyright © 2016 Tugulab. All rights reserved.
//

import Foundation


/// The protocol defining a request
protocol ApiRequest {
    
    /// Endpoint URL
    var endpoint: String { get }
    
    /// Request method
    var method: ApiClient.Method { get }
    
    /// Request params
    var params: [String: AnyObject]? { get }
    
    /// Request headers
    var headers: [String: String] { get }
    
    /// Create a response with a given json
    func responseWithJson(json: [NSObject: AnyObject]) throws -> ApiResponse
    
}


// MARK: - A standard JSON request

protocol JsonApiRequest: ApiRequest { }


extension JsonApiRequest {
    
    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
}
