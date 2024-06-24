//
//  CityDataProvider.swift
//  WeatherApp
//
//  Created by Arsalan on 21.06.2024.
//

import UIKit

protocol CityDataProvider {
    var delegate: CityDataProviderDelegate? { get set }
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

protocol CityDataProviderDelegate: AnyObject {
    func locationFetched()
}

private enum Constants: String {
    case fileName = "city_list"
    case fileExtension = "json"
}

final class CityDataProviderImpl: CityDataProvider {
    static var shared: CityDataProvider = CityDataProviderImpl()
    
    private let locationProvider = LocationProvider()
    private let udStorageManager = UDStorageManager()
    private let cdStorageManager = CDStorageManager()
    
    private var currentLocation: Coordinate?
    
    private var currentPlace: CityData? {
        guard let currentLocation else { return nil }
        
        return CityData(id: .currentPlaceID,
                        name: "Current Place",
                        state: "",
                        country: "",
                        coordinate: currentLocation)
    }
    
    weak var delegate: CityDataProviderDelegate?
    
    var selectedCityList: [CityData] {
        get {
            let cityList: [CityData]? = udStorageManager.object(forKey: .selectedCityList)
            
            if let currentPlace {
                return cityList ?? [currentPlace]
            } else {
                return cityList ?? []
            }
        }
        set {
            udStorageManager.set(object: newValue, forKey: .selectedCityList)
        }
    }
    
    private init() {
        locationProvider.delegate = self
        
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

//  MARK: - Provider's Public Methods
extension CityDataProviderImpl {
    
    func add(_ city: CityData) {
        var selectedCityList: [CityData] = selectedCityList
        selectedCityList.append(city)
        udStorageManager.set(object: selectedCityList, forKey: .selectedCityList)
    }
    
    func delete(_ city: CityData) {
        guard city.id != .currentPlaceID,
              let index = selectedCityList.firstIndex(where: { $0.id == city.id }) else { return }
        
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

//  MARK: - LocationProviderDelegate
extension CityDataProviderImpl: LocationProviderDelegate {
    func setCurrentLocation(_ location: Coordinate?) {
        currentLocation = location
        
        if location != nil {
            delegate?.locationFetched()
        }
    }
    
    func showAlert(_ alertController: UIAlertController) {}
}

extension Int {
     static let currentPlaceID = -999_999_999
 }
