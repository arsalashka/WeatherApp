//
//  MOCKDataProvider.swift
//  WeatherApp
//
//  Created by Arsalan on 23.05.2024.
//

import UIKit

typealias TitleData = TitleView.InputModel

struct MOCKData {
    let titleData: TitleData
}

extension MOCKData {
    static var data: [MOCKData] {
        return [
            MOCKData(titleData: TitleData(title: "Current location",
                                                     subtitle: "Kansas City",
                                                     currentTemp: 28,
                                                     description: "Mostly Sunny",
                                                     minTemp: 15,
                                                     maxTemp: 32)),
            MOCKData(titleData: TitleData(title: "Orlando",
                                                     subtitle: nil,
                                                     currentTemp: 32,
                                                     description: "Sunny",
                                                     minTemp: 24,
                                                     maxTemp: 36)),
            MOCKData(titleData: TitleData(title: "Chicago",
                                                     subtitle: nil,
                                                     currentTemp: 27,
                                                     description: "Mostly Sunny",
                                                     minTemp: 16,
                                                     maxTemp: 30))
        ]
    }
}
