//
//  CityView.swift
//  WeatherApp
//
//  Created by Arsalan on 09.05.2024.
//

import UIKit
import SnapKit

//  MARK: - Input Model
extension CityView {
    struct InputModel {
        let title: String
        let subtitle: String?
        let description: String
        let minTemp: Int
        let maxTemp: Int
        let currentTemp: Int
    }
}

//  MARK: - CityView class
final class CityView: UIView {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let tempLabel = UILabel()
    let descriptionLabel = UILabel()
    let tempLimitsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        snp.makeConstraints { make in
            make.height.equalTo(125)
        }
        
        setupImageView()
        setupTempLabel()
        setupTempLimitsLabel()
        setupTitleLabel()
        setupSubtitleLabel()
        setupDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Public Methods
    func setup(_ model: InputModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        subtitleLabel.isHidden = model.subtitle == nil
        tempLabel.text = "\(model.currentTemp)º"
        descriptionLabel.text = model.description
        tempLimitsLabel.text = "Max: \(model.maxTemp)º, min: \(model.minTemp)º"
    }
    
    //  MARK: - Private Methods
    private func setupImageView() {
        addSubview(imageView)
        imageView.image = .sky
        imageView.alpha = 0.8
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 18
        imageView.clipsToBounds = true
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTempLabel() {
        addSubview(tempLabel)
        tempLabel.font = .systemFont(ofSize: 50 , weight: .light)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .right
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setupTempLimitsLabel() {
        addSubview(tempLimitsLabel)
        tempLimitsLabel.font = .systemFont(ofSize: 13, weight: .medium)
        tempLimitsLabel.textColor = .white
        tempLimitsLabel.textAlignment = .right
        
        tempLimitsLabel.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        titleLabel.textColor = .white
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(tempLabel.snp.leading).offset(-20)
        }
    }
    
    private func setupSubtitleLabel() {
        addSubview(subtitleLabel)
        subtitleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        subtitleLabel.textColor = .white
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(16)
        }
    }
    
    private func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .medium)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 2
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(16)
            make.trailing.equalTo(tempLimitsLabel.snp.leading).offset(-20)
        }
    }
}

#Preview {
    CityView()
}
