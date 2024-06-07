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
    var sections: [CityWeatherViewModel.Section] { get set }
    
    func setupTitle(with data: TitleData)
}

extension CityWeatherViewModel {
    enum Constants: String {
        case titleForFirstSection = "Hourly forecast"
        case titleForSecondSection = "-day forecast"
    }
}

final class CityWeatherViewModel: CityWeatherViewModelInput {
    struct Section: Hashable {
        let imageSystemName: String
        let title: String
        let description: String?
        let items: [Item]
    }
    
    enum Item: Hashable {
        case dayHourlyWeather(data: DayHourlyData)
        case dayWeather(data: DayData)

        var id: String {
            switch self {
            case .dayHourlyWeather(let data): return data.id
            case .dayWeather(let data): return data.id
            }
        }
    }
    
    private let weatherData: CityWeatherData!
    
    weak var output: CityWeatherViewModelOutput?
    
    init(weatherData: CityWeatherData?) {
        self.weatherData = weatherData ?? CityWeatherData.mockData.first
    }
    
    func viewDidLoad() {
        output?.setupTitle(with: weatherData.titleData)
        prepareDataSource()
    }
    
    private func prepareDataSource() {
        output?.sections = [
            Section(imageSystemName: SFSymbolIdentifier.clock.rawValue,
                    title: Constants.titleForFirstSection.rawValue,
                    description: weatherData.dayHourlyDescription,
                    items: weatherData.dayHourlyData.map { .dayHourlyWeather(data: $0) }),
            Section(imageSystemName: SFSymbolIdentifier.calendar.rawValue,
                    title: "\(weatherData.dayData.count)" + Constants.titleForSecondSection.rawValue,
                    description: nil,
                    items: weatherData.dayData.map { .dayWeather(data: $0) })
        ]
    }
}
