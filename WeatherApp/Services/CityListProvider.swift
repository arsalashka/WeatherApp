//
//  CityListProvider.swift
//  WeatherApp
//
//  Created by Arsalan on 11.06.2024.
//

import Foundation

protocol CityListProvider {
    var cityList: [CityData] { get }
    var selectedCityList: [CityData] { get set }

    func add(_ city: CityData)
    func delete(_ city: CityData)
}

private enum Constants: String {
    case fileName = "city_list"
    case fileExtension = "json"
}

final class CityListProviderImpl: CityListProvider {
    
    private let storageManager = UDStorageManager()
    private var currentPlaceCoord = Coordinate(lat: 28.5383, lon: -81.3792)
    
    var cityList: [CityData] = []
    var selectedCityList: [CityData] {
        get {
            let cityList: [CityData]? = storageManager.object(forKey: .selectedCityList)
            return cityList ?? [currentPlace]
        }
        set {
            storageManager.set(object: newValue, forKey: .selectedCityList)
        }
    }
    
    var currentPlace: CityData {
        CityData(id: .currentPlaceID,
                 name: "Current Place",
                 state: "",
                 country: "",
                 coordinate: currentPlaceCoord)
    }
    
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
        print(#function, "selectedCityList.count: \(selectedCityList.count)")
    }
}

//  MARK: - Add and Delete Methods
extension CityListProviderImpl {
    
    func add(_ city: CityData) {
        var selectedCityList: [CityData] = selectedCityList
        selectedCityList.append(city)
        storageManager.set(object: city, forKey: .selectedCityList)
        print(#function, selectedCityList.count)
    }
    
    func delete(_ city: CityData) {
        guard city.id != currentPlace.id,
              let index = selectedCityList.firstIndex(where: { $0.id == currentPlace.id }) else { return }
        
        selectedCityList.remove(at: index)
    }
}

extension Int {
     static let currentPlaceID = -999_999_999
 }
