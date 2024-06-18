//
//  Double + Rounded.swift
//  WeatherApp
//
//  Created by Arsalan on 15.06.2024.
//

import Foundation

extension Double {
    func formatedTemp() -> String {
        let roundedTemp = self.rounded()
        
        return String(format: "%g", roundedTemp) + "º"
    }
}
