//
//  ApiRequest.swift
//  WeatherApp
//
//  Created by Claudio Carnino on 05/09/2016.
//  Copyright © 2016 Tugulab. All rights reserved.
//

import Foundation


/// Api request result
enum ApiRequestResult<T> {
    case Success(T?)
    case Failure(ErrorType?)
}


/// The protocol defining a request
protocol ApiRequest {
    
    /// Endpoint URL
    var endpoint: String { get }
    
    /// Absolute URL composed by baseURL, endpoint component and parameters
    var absoluteURL: NSURL { get }
    
}
