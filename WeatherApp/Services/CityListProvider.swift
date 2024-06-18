//
//  CityListProvider.swift
//  WeatherApp
//
//  Created by Arsalan on 11.06.2024.
//

import Foundation

protocol CityListProvider {
    var cityList: [CityData] { get }

}

extension CityListProviderImpl {
    enum Constants: String {
        case fileName = "city_list"
        case fileExtension = "json"
    }
}

final class CityListProviderImpl: CityListProvider {
    var cityList: [CityData] = []
    
    init() {
        guard let path = Bundle.main.path(
            forResource: Constants.fileName.rawValue,
            ofType: Constants.fileExtension.rawValue
        ),
              let data = FileManager.default.contents(atPath: path)
        else {
            fatalError(
                "Could not find \(Constants.fileName.rawValue).\(Constants.fileExtension.rawValue)"
            )
        }

        let decoder = JSONDecoder()
        
        cityList = try! decoder.decode([CityData].self, from: data)
    }
}
