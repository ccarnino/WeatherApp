//
//  DayForecast.swift
//  WeatherApp
//
//  Created by Claudio Carnino on 05/09/2016.
//  Copyright © 2016 Tugulab. All rights reserved.
//

import Foundation


// Note: ideally our app will have a module just for the model/networking layer. The initializer should be internal,
// which means a DayForecast would be initialized just by the networking layer. It also means that this data structure
// will not be modified anywhere. This improve separation of responsibilities and safety in the codebase
// Note2: ideally we would like to have an enum with all the possible condition codes. So we would match the condition to the right case
// when the response is parsed. Then the icon would be a getter property of the enum case.

/// Immutable data structure representing a day forecase with the informations our app needs
struct DayForecast: Equatable {
    
    let date: NSDate
    let shortDescription: String
    let iconCode: String
    
    /// Computed icon URL
    var iconURL: NSURL? {
        return NSURL(string: "http://openweathermap.org/img/w/\(iconCode).png")
    }
    
}


/// Conform DayForecast to the equatable protocol
func ==(lhs: DayForecast, rhs: DayForecast) -> Bool {
    if lhs.date != rhs.date { return false }
    if lhs.shortDescription != rhs.shortDescription { return false }
    if lhs.iconCode != rhs.iconCode { return false }
    return true
}
