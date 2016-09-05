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
    
    /// Base url of the backend
    let baseURL: NSURL
    
    
    /// Initialize
    init(baseURL: NSURL) {
        self.baseURL = baseURL
    }
    
    
    /// Add and process an api request
    func addRequest(request: ApiRequest, completion: Void) {
        
    }
    
}
