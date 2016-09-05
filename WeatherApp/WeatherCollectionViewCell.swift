//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Claudio Carnino on 05/09/2016.
//  Copyright © 2016 Tugulab. All rights reserved.
//

import UIKit


final class WeatherCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    
    // MARK: - Views
    
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var weatherLabel: UILabel!
    
    
    // MARK: - Values
    
    let dateFormatter: NSDateFormatter = {
        let dayTimePeriodFormatter = NSDateFormatter()
        dayTimePeriodFormatter.dateFormat = "EEEE\nh a"
        return dayTimePeriodFormatter
    }()
    
    var iconImage: UIImage? {
        didSet {
            iconImageView.image = iconImage
        }
    }
    var date: NSDate? {
        didSet {
            if let date = date {
                dateLabel.text = dateFormatter.stringFromDate(date)
            }
        }
    }
    var weatherDescription: String? {
        didSet {
            weatherLabel.text = weatherDescription
        }
    }
    
    
    // MARK: - View lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        dateLabel.text = nil
        weatherLabel.text = nil
    }
    
}
