//
//  ApiResponse.swift
//  WeatherApp
//
//  Created by Claudio Carnino on 05/09/2016.
//  Copyright © 2016 Tugulab. All rights reserved.
//

import Foundation


/// Generic api response
protocol ApiResponse {
    
    init(json: [NSObject: AnyObject]) throws
    
}
