//
//  CityWeatherViewModel.swift
//  WeatherApp
//
//  Created by Arsalan on 31.05.2024.
//

import UIKit

//  MARK: - Protocols
protocol CityWeatherViewModelInput {
    var output: CityWeatherViewModelOutput? { get set }
    
    func viewDidLoad()
}

protocol CityWeatherViewModelOutput: AnyObject {
    var dataSource: [CityWeatherViewModel.Section] { get set }
    
    func setupTitle(with data: TitleView.InputModel)
}


final class CityWeatherViewModel: CityWeatherViewModelInput {
    struct Section {
        let icon: UIImage?
        let title: String?
        let items: [Item]
    }
    
    enum Item {
        case title(data: TitleCell.InputModel)
        case dayHourlyWeather(data: [DayHourlyWeatherCell.InputModel])
        case dayWeather(data: DayWeatherCell.InputModel)
    }
    
    private let weatherData: MOCKData?
    
    weak var output: CityWeatherViewModelOutput?
    
    init(weatherData: MOCKData?) {
        self.weatherData = weatherData
    }
    
    func viewDidLoad() {
        if let weatherData {
            output?.setupTitle(with: weatherData.titleData)
            
            prepareDataSource(with: weatherData)
        }
    }
    
    private func prepareDataSource(with weatherData: MOCKData) {
        var forecastItems: [Item] = weatherData.dayData.map { .dayWeather(data: $0) }
        
        forecastItems.insert(
            .title(data: TitleCell.InputModel(imageSystemName: "calendar",
                                              title: "Forecast for \(weatherData.dayData.count) days")),
            at: 0)
        
        output?.dataSource = [
            Section(icon: nil,
                    title: nil,
                    items: [
                        .title(data: TitleCell.InputModel(imageSystemName: "clock",
                                                          title: "Hourly forecast")),
                        .dayHourlyWeather(data: weatherData.dayHourlyData.data)
                    ]),
            Section(icon: nil,
                    title: nil,
                    items: forecastItems
                    )
        ]
    }
}
