//
//  ReuseIdentifiable.swift
//  WeatherApp
//
//  Created by Claudio Carnino on 05/09/2016.
//  Copyright © 2016 Tugulab. All rights reserved.
//

import Foundation


/// The conformant will have a reuse identifier
protocol ReuseIdentifiable {
    
    static var reuseIdentifier: String { get }
    
}


extension ReuseIdentifiable {
    
    static var reuseIdentifier: String {
        return String(Self.self)
    }
    
}
