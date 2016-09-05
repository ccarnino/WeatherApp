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
    
    /// Request parameters
    var parameters: [String: Any] { get }
    
    /// Request headers
    var headers: [String: Any] { get }
    
//    /// Absolute URL composed by baseURL, endpoint component and parameters
//    var absoluteURL: NSURL { get }
    
}


// MARK: - A standard JSON request

protocol JsonApiRequest: ApiRequest { }


extension JsonApiRequest {
    
    var headers: [String: Any] {
        return ["Content-Type": "application/json"]
    }
    
}
