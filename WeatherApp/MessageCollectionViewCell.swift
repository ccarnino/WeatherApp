//
//  MessageCollectionViewCell.swift
//  WeatherApp
//
//  Created by Claudio Carnino on 05/09/2016.
//  Copyright © 2016 Tugulab. All rights reserved.
//

import UIKit


final class MessageCollectionViewCell: UICollectionViewCell, ReuseIdentifiable {
    
    @IBOutlet private var titleLabel: UILabel!
    
    
    // MARK: - Values
    
    var labelText: String? {
        didSet {
            titleLabel.text = labelText
        }
    }
    
    
    // MARK: - View lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
}
