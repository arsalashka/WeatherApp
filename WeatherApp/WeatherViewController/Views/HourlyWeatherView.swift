//
//  HourlyWeatherView.swift
//  WeatherApp
//
//  Created by Arsalan on 08.05.2024.
//

import UIKit
import SnapKit

final class HourlyWeatherView: UIView {
    struct DataModel {
        let hour: String
        let icon: UIImage?
        let temp: Int
    }
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupScrollView()
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Public Methods
    func setup(_ models: [DataModel]) {
        models.enumerated().forEach { index, model in
            let view = HourWeatherView()
            view.setup(model)
            stackView.addArrangedSubview(view)
            
            if index == 0 {
                stackView.setCustomSpacing(35, after: view)
            }
        }
    }
    
    //  MARK: - Private Methods
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//  MARK: - Extensions
extension HourlyWeatherView {
    final class HourWeatherView: UIView {
        
        private let stackView = UIStackView()
        private let hourLabel = UILabel()
        private let iconView = UIImageView()
        private let tempLabel = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupStackView()
            setupHourLabel()
            setupIconView()
            setupTempLabel()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //  MARK: - Extension's Public Methods
        func setup(_ model: DataModel) {
            hourLabel.text = model.hour
            iconView.image = model.icon
            tempLabel.text = "\(model.temp)º"
        }
        
        //  MARK: - Extension's Private Methods
        private func setupStackView() {
            addSubview(stackView)
            stackView.axis = .vertical
            stackView.spacing = 16
            stackView.distribution = .fillEqually
            
            stackView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        private func setupHourLabel() {
            stackView.addArrangedSubview(hourLabel)
            hourLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            hourLabel.textAlignment = .center
            hourLabel.textColor = .white
        }
        
        private func setupIconView() {
            stackView.addArrangedSubview(iconView)
            iconView.contentMode = .scaleAspectFit
        }
        
        private func setupTempLabel() {
            stackView.addArrangedSubview(tempLabel)
            tempLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            tempLabel.textAlignment = .center
            tempLabel.textColor = .white
        }
    }
}
