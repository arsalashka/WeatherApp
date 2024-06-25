//
//  APIDataProvider.swift
//  WeatherApp
//
//  Created by Arsalan on 14.06.2024.
//

import Foundation

enum AppError: Error {
    case connectivityError
    case decodeJSONfailed
    case apiError(APIError)
    case networkError
    case other(_ error: String? = nil)
    
    case unknown
    
    var description: String {
        switch self {
        case .connectivityError: return "Connectivity Error"
        case .decodeJSONfailed: return "Decode JSON failed"
        case .apiError(let apiError): return apiError.message
        case .networkError: return "Network Error"
        case .other(let error): return error ?? "Unknown Error"
        case .unknown: return "Unknown Error"
        }
    }
}

final class APIDataProvider {
    private let endpointProvider = APIEndpointProvider()
    
    func getData<T: Decodable>(for endpoint: Endpoint,
                               completionHandler: @escaping (T) -> Void,
                               errorHandler: @escaping (AppError) -> Void) {
        let request = URLRequest(url: endpointProvider.getURL(with: endpoint))
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                errorHandler(.connectivityError)
            } else {
                guard let data,
                      let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                    errorHandler(.networkError)
                    return
                }
                
                let decoder = JSONDecoder()
                
                print("Request URL: ", request.url ?? "Error: Could not unwrap URL")
                
                if (200...299) ~= statusCode {
                    do {
                        let object = try decoder.decode(T.self, from: data)
                        completionHandler(object)
                    } catch {
                        errorHandler(.decodeJSONfailed)
                    }
                } else {
                    do {
                        let error = try decoder.decode(APIError.self, from: data)
                        errorHandler(.apiError(error))
                    } catch {
                        errorHandler(.unknown)
                    }
                }
            }
        }.resume()
    }
}
