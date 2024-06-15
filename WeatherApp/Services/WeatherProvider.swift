//
//  WeatherProvider.swift
//  WeatherApp
//
//  Created by Arsalan on 09.06.2024.
//

import Foundation

protocol WeatherProvider {
    var delegate: WeatherProviderDelegate? { get set }
    
    func sceneDidEnterBackground()
    func sceneWillEnterForeground()
    
    func getForecastForCity(with id: Int,
                            completionHandler: @escaping (CityWeatherData) -> Void,
                            errorHandler: ((AppError) -> Void)?)
}

protocol WeatherProviderDelegate: AnyObject {
    func setCurrentWeather(_ data: [CityWeatherData])
}

final class WeatherProviderImpl: WeatherProvider {
    weak var delegate: WeatherProviderDelegate?
    private let dataProvider = APIDataProvider()
    private var currentPlaceCoordinates = Coordinate(lat: 28.5383, lon: -81.3792)
    private var weatherDataCache: [Int: CityWeatherData] = [:]
    private var weatherCache: [Int: WeatherResponse] = [:]
    private var forecastCache: [Int: ForecastResponse] = [:]
    
    func sceneDidEnterBackground() {
        print(#function)
    }
    
    func sceneWillEnterForeground() {
        delegate?.setCurrentWeather(CityWeatherData.mockData)
        
        weatherDataCache = CityWeatherData.mockData
        
        print(#function)
    }
    
    func getForecastForCity(with id: Int, completionHandler: @escaping (CityWeatherData) -> Void, errorHandler: ((AppError) -> Void)?) {
        <#code#>
    }
}
