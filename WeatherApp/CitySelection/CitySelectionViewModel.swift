//
//  CitySelectionViewModel.swift
//  WeatherApp
//
//  Created by Arsalan on 06.06.2024.
//

import UIKit

protocol CitySelectionViewModelInput {
    var output: CitySelectionViewModelOutput? { get set }
    
    func viewDidLoad()
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

final class CitySelectionViewModel: CitySelectionViewModelInput {
        
    weak var output: CitySelectionViewModelOutput?
    private var weatherProvider: WeatherProvider?
    
    init(weatherProvider: WeatherProvider) {
        self.weatherProvider = weatherProvider
        self.weatherProvider?.delegate = self
    }
    
    func viewDidLoad() {
        prepareSections(with: weatherProvider?.weatherDataCache ?? [])
    }
    
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

extension CitySelectionViewModel: WeatherProviderDelegate {
    func setCurrentWeather(_ data: [CityWeatherData]) {
        prepareSections(with: data)
    }
}
