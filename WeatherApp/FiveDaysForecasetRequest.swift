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
    
    
    func responseWithJson(json: [NSObject: AnyObject]) throws -> ApiResponse {
        return try FiveDaysForecastResponse(json: json)
    }
    
}


/// Five days forecast api response
final class FiveDaysForecastResponse: ApiResponse {
    
    /// The data structure containing the forecast
    let forecast: [DayForecast]
    
    
    /// Init the response with the json received by the server
    init(json: [NSObject: AnyObject]) throws {
        
        guard let list = json["list"] as? [[NSObject: AnyObject]] else {
            throw ApiClient.Error.ErrorParsingTheResponse
        }
        
        var forecast = [DayForecast]()
        
        // Loop over the days in the forcast
        for listItem in list {
            guard let dateTimeinterval = listItem["dt"] as? NSTimeInterval,
                let weatherInfos = listItem["weather"] as? [AnyObject],
                let weatherInfo = weatherInfos.first as? [String: AnyObject],
                let shortDescription = weatherInfo["main"] as? String,
                let iconCode = weatherInfo["icon"] as? String else {
                    throw ApiClient.Error.ErrorParsingTheResponse
            }
            
            let date = NSDate(timeIntervalSince1970: dateTimeinterval)
            let dayForecast = DayForecast(date: date, shortDescription: shortDescription, iconCode: iconCode)
            forecast.append(dayForecast)
        }
        
        // Save the parsed forcast
        self.forecast = forecast
    }
    
}
