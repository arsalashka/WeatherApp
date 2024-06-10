//
//  WeatherProvider.swift
//  WeatherApp
//
//  Created by Arsalan on 09.06.2024.
//

import Foundation

protocol WeatherProvider {
    var delegate: WeatherProviderDelegate? { get set }
    var weatherDataCache: [CityWeatherData] { get set }
    
    func sceneDidEnterBackground()
    func sceneWillEnterForeground()
}

protocol WeatherProviderDelegate: AnyObject {
    func setCurrentWeather(_ data: [CityWeatherData])
}

final class WeatherProviderImpl: WeatherProvider {
    
    weak var delegate: WeatherProviderDelegate?
    var weatherDataCache: [CityWeatherData] = []
    
    func sceneDidEnterBackground() {
        print(#function)
    }
    
    func sceneWillEnterForeground() {
        delegate?.setCurrentWeather(CityWeatherData.mockData)
        
        weatherDataCache = CityWeatherData.mockData
        
        print(#function)
    }
}
