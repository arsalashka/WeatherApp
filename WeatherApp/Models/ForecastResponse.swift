//
//  ForecastResponse.swift
//  WeatherApp
//
//  Created by Arsalan on 11.06.2024.
//

import Foundation

//api.openweathermap.org/data/2.5/forecast?lat=28.538336&lon=-81.379234&appid=d7a160a95734d0dfd7aba3e91429e25d

struct ForecastResponse: Codable {
    let count: Int
    let list: [ItemData]
    let city: CityData
    
    enum CodingKeys: String, CodingKey {
        case count = "cnt"
        case list
        case city
    }
}

extension ForecastResponse {
    
}

struct ItemData: Codable {
    let dateUnix: Int
    let main: [MainData]
    let weather: [WeatherData]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let probabilityOfPrecipitation: Double
    let rain: RainData?
    let snow: SnowData?
    let system: SystemData
    
    enum CodingKeys: String, CodingKey {
        case dateUnix = "dt"
        case main
        case weather
        case clouds
        case wind
        case visibility
        case probabilityOfPrecipitation = "pop"
        case rain
        case snow
        case system = "sys"
    }
}

struct CityData: Codable {
    let id: Int
    let name: String
    let coord: Coordinate
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}
