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
    @IBOutlet private var titleLabel: UILabel!
    
    
    // MARK: - Values
    
    var iconImage: UIImage? {
        didSet {
            iconImageView.image = iconImage
        }
    }
    var labelText: String? {
        didSet {
            titleLabel.text = labelText
        }
    }
    
    
    // MARK: - View lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        titleLabel.text = nil
    }
    
}
