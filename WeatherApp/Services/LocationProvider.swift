//
//  LocationProvider.swift
//  WeatherApp
//
//  Created by Arsalan on 22.06.2024.
//

import CoreLocation
import UIKit

protocol LocationProviderDelegate: AnyObject {
    func setCurrentLocation(_ location: Coordinate?)
    func showAlert(_ alertController: UIAlertController)
}

final class LocationProvider:NSObject {
    
    private let locationManager = CLLocationManager()
    private var currentLocation: Coordinate?
    weak var delegate: LocationProviderDelegate?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        checkAuthorization()
    }
    
    //  MARK: - Public Methods
    func getCurrentLocation() -> Coordinate? {
        checkAuthorization()
        
        return currentLocation
    }
    
    //  MARK: - Private Methods
    private func checkAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .denied, .restricted:
            showMoveSettingsAlert()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        @unknown default:
            break
        }
    }
    
    private func showMoveSettingsAlert() {
        let alertController = UIAlertController(title: "Location is not available", message: "Need access to your location", preferredStyle: .alert)
        
        alertController.addAction(
            UIAlertAction(
                title: "Ok",
                style: .default
            ) { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }
        )
        
        alertController.addAction(
            UIAlertAction(title: "Cancel", style: .cancel)
        )
        
        delegate?.showAlert(alertController)
    }
}

//  MARK: - CLLocationManagerDelegate
extension LocationProvider: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else { return }
        
        currentLocation = Coordinate(lat: coordinate.latitude, lon: coordinate.longitude)
        delegate?.setCurrentLocation(currentLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}
