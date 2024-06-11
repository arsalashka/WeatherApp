//
//  CityListModel.swift
//  WeatherApp
//
//  Created by Arsalan on 11.06.2024.
//

import Foundation

struct City: Codable {
    let id: Int
    let name: String
    let state: String
    let country: String
    let coord: Coordinate
}
