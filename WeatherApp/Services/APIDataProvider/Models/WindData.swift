//
//  WindData.swift
//  WeatherApp
//
//  Created by Arsalan on 15.06.2024.
//

import Foundation

struct WindData: Decodable {
    let speed: Double
    let degree: Double
    let gust: Double?
    
    enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
        case gust
    }
}
