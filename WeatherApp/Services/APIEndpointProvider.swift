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
            fatalError()
        }
        
        appID = saveAppID
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = version
        
        guard let saveURL = urlComponents.url else { fatalError() }
        baseURL = saveURL
        
        print(baseURL)
    }
}
