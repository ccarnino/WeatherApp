//
//  DayForecast+IconImage.swift
//  WeatherApp
//
//  Created by Claudio Carnino on 05/09/2016.
//  Copyright © 2016 Tugulab. All rights reserved.
//

import UIKit


/// Extend the DayForecast data structure with a method to fetch asynchronously the icon image
/// This method is into an extention in the app-layer, not in the model layer, because it's related
/// To the specific needs of the view.
extension DayForecast {
    
    func fetchIconImage(completion: (UIImage? -> Void)) {
        
        // Fetching the image in background.
        // Note: here is mising a caching layer, to cache the icons previously fetched
        let backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
        dispatch_async(backgroundQueue) {
            
            // Fetch the image
            // Note: We guard the creationg of the image so we are sure that we manage a fetching failure
            guard let iconURL = self.iconURL,
                let imageData = NSData(contentsOfURL: iconURL),
                let image = UIImage(data: imageData) else {
                    
                    // Call completion on the main thread
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(nil)
                    })
                    return
            }
            
            // Call completion on the main thread
            dispatch_async(dispatch_get_main_queue(), {
                completion(image)
            })
        }
    }
    
}
