//
//  UIImage+SystemName.swift
//  WeatherApp
//
//  Created by Arsalan on 22.05.2024.
//

import UIKit

enum SFSymbolIdentifier: String {
    case ellipsisCircle = "ellipsis.circle"
    case micFill = "mic.fill"
    case cloudSun = "cloud.sun"
    case cloudSunFill = "cloud.sun.fill"
    case xCircleFill = "x.circle.fill"
    case sunMaxFill = "sun.max.fill"
    case sunRainFill = "sun.rain.fill"
    case cloudSunRainFill = "cloud.sun.rain.fill"
    
}

extension UIImage {
    convenience init?(systemSymbol: SFSymbolIdentifier) {
        self.init(systemName: systemSymbol.rawValue)
    }
}
