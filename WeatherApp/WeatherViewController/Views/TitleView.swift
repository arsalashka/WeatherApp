//
//  TitleView.swift
//  WeatherApp
//
//  Created by Arsalan on 07.05.2024.
//

import UIKit
import SnapKit

final class TitleView: UIView {
    //  MARK: - Properties
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let tempLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let tempLimitsLabel = UILabel()
    
    //  MARK: - Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStackView()
        setupTitleLabel()
        setupSubTitleLabel()
        setupTempLabel()
        setupDescriptionLabel()
        setupTempLimitsLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Public Methods
    func setup(_ data: TitleData) {
        titleLabel.text = data.title
        subTitleLabel.text = data.subtitle
        subTitleLabel.isHidden = data.subtitle == nil
        tempLabel.text = "\(data.currentTemp)º"
        descriptionLabel.text = data.description
        tempLimitsLabel.text = "Max: \(data.maxTemp)º, min: \(data.minTemp)º"
    }
    
    //  MARK: - Private Methods for setup UI elements
    private func setupStackView() {
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTitleLabel() {
        stackView.addArrangedSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
    }
    
    private func setupSubTitleLabel() {
        stackView.addArrangedSubview(subTitleLabel)
        subTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        subTitleLabel.textAlignment = .center
        subTitleLabel.textColor = .white
    }
    
    private func setupTempLabel() {
        stackView.addArrangedSubview(tempLabel)
        tempLabel.font = UIFont.systemFont(ofSize: 92, weight: .thin)
        tempLabel.textAlignment = .center
        tempLabel.textColor = .white
    }
    
    private func setupDescriptionLabel() {
        stackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .white
    }
    
    private func setupTempLimitsLabel() {
        stackView.addArrangedSubview(tempLimitsLabel)
        tempLimitsLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        tempLimitsLabel.textAlignment = .center
        tempLimitsLabel.textColor = .white
    }
    
}
