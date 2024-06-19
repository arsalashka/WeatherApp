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
    case sunFill = "sun.fill"
    case cloudSunFill = "cloud.sun.fill"
    case xCircleFill = "x.circle.fill"
    case sunMaxFill = "sun.max.fill"
    case sunRainFill = "sun.rain.fill"
    case cloudSunRainFill = "cloud.sun.rain.fill"
    case questionmarkCircle = "questionmark.circle"
    case calendar = "calendar"
    case clock = "clock"
}

extension UIImage {
    convenience init?(systemSymbol: SFSymbolIdentifier) {
        self.init(systemName: systemSymbol.rawValue)
    }
}
