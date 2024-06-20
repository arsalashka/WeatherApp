//
//  APIEndpointProvider.swift
//  WeatherApp
//
//  Created by Arsalan on 11.06.2024.
//

import Foundation

extension APIEndpointProvider {
    enum Constants: String {
        case fileName = "Config"
        case fileExtension = "plist"
        case addID = "appID"
        case api = "api"
        case host = "host"
        case scheme = "scheme"
        case version = "version"
    }
}

enum Endpoint {
    case weather(id: Int)
    case forecast(id: Int)
    case coordWeather(Coordinate)
    case coordForecast(Coordinate)
    case group(ids: [Int])

    var pathComponent: String {
        switch self {
        case .weather, .coordWeather: return "weather"
        case .forecast, .coordForecast: return "forecast"
        case .group: return "group"
        }
    }
}

final class APIEndpointProvider {
    private let appID: String
    private let baseURL: URL
    
    init() {
        var format = PropertyListSerialization.PropertyListFormat.xml
        
        guard let path = Bundle.main.path(forResource: Constants.fileName.rawValue, ofType: Constants.fileExtension.rawValue),
              let data = FileManager.default.contents(atPath: path),
              let config = try? PropertyListSerialization.propertyList(
                from: data,
                options: .mutableContainersAndLeaves,
                format: &format
              ) as? [String: Any] else {
            fatalError("\(Constants.fileName.rawValue).\(Constants.fileExtension.rawValue) not found")
        }
        
        guard let saveAppID = config[Constants.addID.rawValue] as? String,
              let api = config[Constants.api.rawValue] as? [String: Any],
              let host = api[Constants.host.rawValue] as? String,
              let scheme = api[Constants.scheme.rawValue] as? String,
              let version = api[Constants.version.rawValue] as? String
        else {
            fatalError("Could not unwrap \(Constants.api.rawValue) or other elements in \(Constants.fileName.rawValue).\(Constants.fileExtension.rawValue)")
        }
        
        appID = saveAppID
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = version
        
        guard let saveURL = urlComponents.url else {
            fatalError("Could not unwrap urlComponents.url")
        }
        baseURL = saveURL
    }
    
    func getURL(with endpoint: Endpoint) -> URL {
        var url = baseURL
        
        url.append(path: endpoint.pathComponent)
        
        switch endpoint {
        case .weather(let id), .forecast(let id):
            url.append(queryItems: [URLQueryItem(name: "id", value: String(id))])
        case .coordWeather(let coordinate), .coordForecast(let coordinate):
            url.append(queryItems: [
                URLQueryItem(name: "lat", value: String(coordinate.lat)),
                URLQueryItem(name: "lon", value: String(coordinate.lon))
            
            ])
        case .group(let ids):
            url.append(queryItems: [
                URLQueryItem(name: "id",value: ids.map { String($0) }.joined(separator: ","))
            ])
        }
        
        url.append(queryItems: [
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: appID)
        ])
        
        print(url)
        
        return url
    }
}
