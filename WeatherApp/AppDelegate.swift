//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Claudio Carnino on 05/09/2016.
//  Copyright © 2016 Tugulab. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var apiClient: ApiClient?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Configure the api client
        let weatherServiceApiKey = "12a1ee0679a0fc492e51b35da3f7fc57"
        let baseURL = NSURL(string: "http://api.openweathermap.org/data/2.5/")!
        self.apiClient = ApiClient(apiKey: weatherServiceApiKey, baseURL: baseURL)
        
        // Pass the api client to the first view controller, which should be a WeatherCollectionViewController
        guard let window = self.window,
            let weatherCollectionVC = window.rootViewController as? WeatherCollectionViewController else {
                // Not able to start the app.
                // An error should be reported to our servers
                // The user should be notified
                return false
        }
        weatherCollectionVC.apiClient = apiClient
        
        return true
    }
}

