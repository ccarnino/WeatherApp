//
//  FiveDaysForecasetRequest.swift
//  WeatherApp
//
//  Created by Claudio Carnino on 05/09/2016.
//  Copyright © 2016 Tugulab. All rights reserved.
//

import Foundation


/// Five days forecast api request
final class FiveDaysForecasetRequest: JsonApiRequest {
    
    let endpoint = "forecast"
    let method = ApiClient.Method.GET
    var params: [String : AnyObject]? {
        return ["q": "\(city),\(countryCode)"]
    }
    
    let city: String
    let countryCode: String
    
    
    init(city: String, countryCode: String) {
        self.city = city
        self.countryCode = countryCode
    }
    
    
    func responseWithJson(json: NSDictionary) throws -> ApiResponse {
        return try FiveDaysForecastResponse(json: json)
    }
    
}


/// Five days forecast api response


final class FiveDaysForecastResponse: ApiResponse {
    
    /// The data structure containing the forecast
    let forecast: [DayForecast]
    
    
    /// Init the response with the json received by the server
    init(json: NSDictionary) throws {
        
        forecast = []
    }
    
}
