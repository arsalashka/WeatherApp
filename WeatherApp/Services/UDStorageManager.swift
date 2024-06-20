//
//  UDStorageManager.swift
//  WeatherApp
//
//  Created by Arsalan on 20.06.2024.
//

import Foundation

enum StorageKey: String {
    case weatherUploadDate
    case cityListStored
    case selectedCityList
}

final class UDStorageManager {
    
    private let userDefaults = UserDefaults.standard
    
    func set<T: Codable>(object: T, forKey key: StorageKey) {
        guard let data = try? JSONEncoder().encode(object) else { return }
        
        userDefaults.set(data, forKey: key.rawValue)
    }
    
    func object<T: Codable>(forKey key: StorageKey) -> T? {
        guard let data = userDefaults.object(forKey: key.rawValue) as? Data else { return nil }
        
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    func delete(forKey key: StorageKey) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
