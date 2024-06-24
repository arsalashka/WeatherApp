//
//  CitySelectionViewModel.swift
//  WeatherApp
//
//  Created by Arsalan on 06.06.2024.
//

import UIKit

//  MARK: - Protocols
protocol CitySelectionViewModelInput {
    var output: CitySelectionViewModelOutput? { get set }
    
    func getForecastForCity(with id: Int?)
    func getWeatherForCityList(forced: Bool)
}

extension CitySelectionViewModelInput {
    func getWeatherForCityList(forced: Bool = false) {
        getWeatherForCityList(forced: forced)
    }
}

protocol CitySelectionViewModelOutput: AnyObject {
    var sections: [CitySelectionViewModel.Section] { get set }
}

extension CitySelectionViewModel {
    struct Section: Hashable {
        let items: [CityWeatherData]
        let footerAttributedString: NSAttributedString?
    }
}

extension CitySelectionViewModel {
    enum Constants: String {
        case linkRangeString = "meteorological data"
        case footerText = "Learn more about meteorological data"
        case urlString = "https://meteoinfo.ru/t-scale"
    }
}

//  MARK: - Class
final class CitySelectionViewModel: CitySelectionViewModelInput {
    private let storageManager = UDStorageManager()
    private let cityDataProvider = CityDataProviderImpl.shared
    
    weak var output: CitySelectionViewModelOutput?
    private var weatherProvider: WeatherProvider?
    
    var cityList: [CityData] {
        cityDataProvider.selectedCityList
    }
    
    init(weatherProvider: WeatherProvider) {
        self.weatherProvider = weatherProvider
        self.weatherProvider?.delegate = self
        prepareSections(with: cityList.map(\.weatherData))
        getWeatherForCityList()
    }
    
    //  MARK: - Public Methods
    func getWeatherForCityList(forced: Bool) {
        weatherProvider?.getWeatherFor(cityList, forced: forced) { [weak self] data in
            guard let self else { return }
            
            let sortedData = cityList.compactMap { data[$0.id] ?? $0.weatherData }
            prepareSections(with: sortedData)
        } errorHandler: { error in
            print(error.description)
        }
    }
    
    func getForecastForCity(with id: Int?) {
             guard let id, let cityData = cityList.first(where: { $0.id == id }) else { return }

             weatherProvider?.getForecastForCity(cityData) { [weak self] data in
                 guard let self else { return }
                 let sortedData = cityList.compactMap { data[$0.id] ?? $0.weatherData }
                 prepareSections(with: sortedData)
             } errorHandler: { error in
                 print(error.description)
             }
        }
    
    //  MARK: - Private Methods
    private func prepareSections(with data: [CityWeatherData]) {
        output?.sections = [Section(items: data, footerAttributedString: createFooterString())]
    }
    
    private func createFooterString() -> NSAttributedString {
        let text = Constants.footerText.rawValue
        let attributedString = NSMutableAttributedString(
            string: text,
            attributes: [.foregroundColor: UIColor.gray]
        )
        if let url = URL(string: Constants.urlString.rawValue) {
            let linkRange = (text as NSString).range(of: Constants.linkRangeString.rawValue)
            
            attributedString.addAttributes([.link: url], range: linkRange)
        }
        
        return attributedString
    }
}

//  MARK: - WeatherProviderDelegate
extension CitySelectionViewModel: WeatherProviderDelegate {
    func setCurrentWeather(_ data: [Int: CityWeatherData]) {
        let sortedData = cityList.compactMap { data[$0.id] ?? $0.weatherData }
        prepareSections(with: sortedData)
    }
}
