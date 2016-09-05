//
//  WeatherCollectionViewController.swift
//  WeatherApp
//
//  Created by Claudio Carnino on 05/09/2016.
//  Copyright © 2016 Tugulab. All rights reserved.
//

import UIKit


class WeatherCollectionViewController: UICollectionViewController {
    
    /// The source of truth for the state of the view
    private enum ViewState {
        case Loading
        case Error(ErrorType?)
        case Ready([DayForecast])
    }
    
    private enum Error: ErrorType {
        case SomethingWentWrongFetchingTheForecast
    }
    
    
    // MARK: - Values
    
    var apiClient: ApiClient!
    
    /// The state of the view. Every set triggers an automatic refresh view to reflect the new state
    private var viewState: ViewState = .Loading {
        didSet {
            refreshView()
        }
    }
    
    
    // MARK: - App lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set loading state
        viewState = .Loading
        
        // Ask the weather for london
        let forecastRequest = FiveDaysForecasetRequest(city: "london", countryCode: "gb")
        apiClient.addRequest(forecastRequest) { [weak self] result in
            
            // We use weak self to avoid retain cycles
            switch result {
            case .Success(let response):
                // Make sure that the response is of the expected type
                guard let forecastResponse = response as? FiveDaysForecastResponse else {
                    self?.viewState = .Error(Error.SomethingWentWrongFetchingTheForecast)
                    return
                }
                // Set the ready state
                self?.viewState = .Ready(forecastResponse.forecast)
                
            case .Failure(let error) where error != nil:
                // If the error is set pass it back
                self?.viewState = .Error(error)
                
            default:
                // Set generic error
                self?.viewState = .Error(Error.SomethingWentWrongFetchingTheForecast)
            }
        }
    }
    
    
    private func refreshView() {
        // Reload the table view which holds all the views of the current VC
        collectionView?.reloadData()
    }
    
}


// MARK: - UICollectionViewDataSource

extension WeatherCollectionViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewState {
        case .Loading, .Error(_):
            return 1
            
        case .Ready(let forecasts):
            return forecasts.count
        }
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        switch viewState {
        case .Loading:
            let loadingCell = collectionView.dequeueReusableCellWithReuseIdentifier(MessageCollectionViewCell.reuseIdentifier, forIndexPath: indexPath) as! MessageCollectionViewCell
            loadingCell.labelText = "Loading the weather..."
            return loadingCell
            
        case .Error(_):
            let errorCell = collectionView.dequeueReusableCellWithReuseIdentifier(MessageCollectionViewCell.reuseIdentifier, forIndexPath: indexPath) as! MessageCollectionViewCell
            // For now just communicating a generic error to the user
            errorCell.labelText = "Something went wrong fetching the weather"
            return errorCell
            
        case .Ready(let forecasts):
            let dayForecast = forecasts[indexPath.item]
            let weatherCell = collectionView.dequeueReusableCellWithReuseIdentifier(WeatherCollectionViewCell.reuseIdentifier, forIndexPath: indexPath) as! WeatherCollectionViewCell
            weatherCell.labelText = dayForecast.shortDescription
            
            // Load the icon asyncronoysly
            dayForecast.fetchIconImage({ iconImage in
                // We should check that the current weatherCell is still associated to the current dayForecast.
                guard let cellIndexPath = collectionView.indexPathForCell(weatherCell) else {
                    // The cell is not displayed anymore, so no icon to update
                    return
                }
                let cellDayForecast = forecasts[cellIndexPath.item]
                guard cellDayForecast == dayForecast else {
                    // The cell has been recycled for another day forecast. We should not update the icon anymore
                    return
                }
                weatherCell.iconImage = iconImage
            })
            
            return weatherCell
        }
    }
    
}


// MARK: - UICollectionViewDelegateFlowLayout

extension WeatherCollectionViewController {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // Calculate the available horizontal space
        let availableWidth = collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right
        
        switch viewState {
        case .Loading, .Error(_):
            let availableHeight = collectionView.frame.height - collectionView.contentInset.top - collectionView.contentInset.bottom
            return CGSize(width: availableWidth, height: availableHeight)
            
        case .Ready(_):
            // Forcing N days per row
            let numberOfDaysPerRow = 5
            let cellWidth = availableWidth / CGFloat(numberOfDaysPerRow)
            let cellHeight: CGFloat = 115
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
    
}
