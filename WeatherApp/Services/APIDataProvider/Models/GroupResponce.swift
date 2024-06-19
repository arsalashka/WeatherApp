//
//  GroupResponce.swift
//  WeatherApp
//
//  Created by Arsalan on 15.06.2024.
//

import Foundation

struct GroupResponse: Decodable {
    let count: Int
    let list: [WeatherResponse]
    
    enum CodingKeys: String, CodingKey {
        case count = "cnt"
        case list
    }
}
