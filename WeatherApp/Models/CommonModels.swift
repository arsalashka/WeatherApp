//
//  CommonModels.swift
//  WeatherApp
//
//  Created by Arsalan on 11.06.2024.
//

import Foundation

struct MainData: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let pressureSeaLevel: Int
    let pressureGroundLevel: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case pressureSeaLevel = "sea_level"
        case pressureGroundLevel = "grnd_level"
        case humidity
    }
}

struct WeatherData: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Clouds: Codable {
    let all: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct RainData: Codable {
    let volumeOf3h: Double
    
    enum CodingKeys: String, CodingKey {
        case volumeOf3h = "3h"
    }
}

struct SnowData: Codable {
    let volumeOf3h: Double
    
    enum CodingKeys: String, CodingKey {
        case volumeOf3h = "3h"
    }
}

struct SystemData: Codable {
    let partOfDay: String
    
    enum CodingKeys: String, CodingKey {
        case partOfDay = "pod"
    }
}

struct Coordinate: Codable {
    let lat: Double
    let lon: Double
}
