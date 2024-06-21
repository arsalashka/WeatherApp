//
//  CityDataProvider.swift
//  WeatherApp
//
//  Created by Arsalan on 21.06.2024.
//

import Foundation

protocol CityDataProvider {
    static var shared: CityDataProvider { get }
    var selectedCityList: [CityData] { get set }

    func add(_ city: CityData)
    func delete(_ city: CityData)
    func getCityList(with searchQuery: String?, completion: @escaping ([CityData]?) -> Void)
}

extension CityDataProvider {
    func getCityList(with searchQuery: String? = nil, completion: @escaping ([CityData]?) -> Void) {
        getCityList(with: searchQuery, completion: completion)
    }
}

private enum Constants: String {
    case fileName = "city_list"
    case fileExtension = "json"
}

final class CityListProviderImpl: CityDataProvider {
    static var shared: CityDataProvider = CityListProviderImpl()
    
    private let udStorageManager = UDStorageManager()
    private let cdStorageManager = CDStorageManager()
    
    private var currentPlaceCoord = Coordinate(lat: 28.5383, lon: -81.3792)
    
    var selectedCityList: [CityData] {
        get {
            let cityList: [CityData]? = udStorageManager.object(forKey: .selectedCityList)
            return cityList ?? [currentPlace]
        }
        set {
            udStorageManager.set(object: newValue, forKey: .selectedCityList)
        }
    }
    
    var currentPlace: CityData {
        CityData(id: .currentPlaceID,
                 name: "Current Place",
                 state: "",
                 country: "",
                 coordinate: currentPlaceCoord)
    }
    
    private init() {
        if udStorageManager.object(forKey: .cityListStored) != true {
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
            
            guard let cityList = try? JSONDecoder().decode([CityData].self, from: data) else {
                fatalError("Could not decode data")
            }
            
            cdStorageManager.storeCityData(cityList) { [weak self] result in
                self?.udStorageManager.set(object: result, forKey: .cityListStored)
                print("cityList stored: \(result)")
            }
        }
    }
}

//  MARK: - Provider Methods
extension CityListProviderImpl {
    
    func add(_ city: CityData) {
        var selectedCityList: [CityData] = selectedCityList
        selectedCityList.append(city)
        udStorageManager.set(object: selectedCityList, forKey: .selectedCityList)
    }
    
    func delete(_ city: CityData) {
        guard city.id != currentPlace.id,
              let index = selectedCityList.firstIndex(where: { $0.id == currentPlace.id }) else { return }
        
        selectedCityList.remove(at: index)
    }
    
    func getCityList(with searchQuery: String?, completion: @escaping ([CityData]?) -> Void) {
        if let searchQuery {
            cdStorageManager.fetchCityData(with: searchQuery, completion: completion)
        } else {
            cdStorageManager.fetchCityData(completion: completion)
        }
    }
}

extension Int {
     static let currentPlaceID = -999_999_999
 }
