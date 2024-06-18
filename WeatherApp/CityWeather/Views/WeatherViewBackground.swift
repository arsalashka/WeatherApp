//
//  WeatherViewBackground.swift
//  WeatherApp
//
//  Created by Arsalan on 07.06.2024.
//

import UIKit

final class WeatherViewBackground: UICollectionReusableView {
    static let id = String(describing: WeatherViewBackground.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightBlue
        layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Public Methods
    func setup(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
    }
}
