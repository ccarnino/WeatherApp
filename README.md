# Weather App

## Structure
The app is divided in 3 layers:

- Model
	- Networking (ApiClient, Request, Response)
	- Data structures (DayForecast)
- Controller (WeatherCollectionViewController)
- View (Main.storyboard)


## App lifecycle
The app lauches and the WeatherCollectionViewController is the first (and only) view controller to be loaded. The method `refreshView` is in charge of refreshing the view to reflect the state of the model `forecast`.

So, at startup the forecast is not available yet, so a temporary message will be displayed.

The networking is initialized by the app delegate and passed by reference to the children VCs.

The WeatherCollectionViewController will asyncronously ask the networking stack the weather forcasts and when retrieved, it will display it through the `refreshView`.

In this case the `refreshView` just reload the collection view, but it would be where everything view related is updated.


## Notes
- A collection view is used to display the weather because it is perfect for horizontal display of informations. It also adapts better to different screens sizes than a table view. So it will be better for iPad.


## Author
Claudio Carnino, Tugulab Ltd.