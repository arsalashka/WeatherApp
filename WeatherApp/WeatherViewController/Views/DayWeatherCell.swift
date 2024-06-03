//
//  DayWeatherCell.swift
//  WeatherApp
//
//  Created by Arsalan on 31.05.2024.
//

import UIKit
import SnapKit

final class DayWeatherCell: UITableViewCell {
    struct InputModel {
        let title: String
        let imageSystemName: String
        let minTemp: Double
        let maxTemp: Double
        let minDayTemp: Double
        let maxDayTemp: Double
        let currentTemp: Double?
    }
    
    //    MARK: - Properties
    static let dayWeatherCellID = "DayWeatherCellID"
    
    private let titleLabel = UILabel()
    private let iconView = UIImageView()
    private let minTempLabel = UILabel()
    private let tempLimitsView = TempLimitsView()
    private let maxTempLabel = UILabel()
    
    //    MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupTitleLabel()
        setupIconView()
        setupMinTempLabel()
        setupTempLimitsView()
        setupMaxTempLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview()
        }
    }
    
    //  MARK: - Public Methods
    func setup(_ inputModel: InputModel) {
        titleLabel.text = inputModel.title
        iconView.image = UIImage(systemName: inputModel.imageSystemName)?.withRenderingMode(.alwaysOriginal)
        minTempLabel.text = "\(Int(inputModel.minDayTemp))º"
        maxTempLabel.text = "\(Int(inputModel.maxDayTemp))º"
        tempLimitsView.setup(inputModel)
    }
    
    //  MARK: - Private Methods
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .white
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(12)
            make.width.equalTo(60)
        }
    }
    
    private func setupIconView() {
        contentView.addSubview(iconView)
        iconView.contentMode = .scaleAspectFit
        
        iconView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupMinTempLabel() {
        contentView.addSubview(minTempLabel)
        minTempLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        minTempLabel.textColor = .white.withAlphaComponent(0.7)
        minTempLabel.textAlignment = .center
        
        minTempLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconView.snp.trailing).offset(16)
            make.width.equalTo(30)
        }
    }
    
    private func setupTempLimitsView() {
        contentView.addSubview(tempLimitsView)
        
        tempLimitsView.snp.makeConstraints { make in
            make.leading.equalTo(minTempLabel.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupMaxTempLabel() {
        contentView.addSubview(maxTempLabel)
        maxTempLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        maxTempLabel.textAlignment = .center
        maxTempLabel.textColor = .white.withAlphaComponent(0.7)
        
        maxTempLabel.snp.makeConstraints { make in
            make.leading.equalTo(tempLimitsView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(30)
        }
    }
    
}

extension DayWeatherCell {
    //  MARK: - TempLimitsView Class
    final class TempLimitsView: UIView {
        private let tempLimitsView = UIView()
        private let currentTempView = UIView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupView()
            setupTempLimitsView()
            setupCurrentTempView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        //  MARK: - Public Methods
        func setup(_ model: InputModel) {
            let weekTempDiff = model.maxTemp - model.minTemp
            let minOffset = abs(model.minTemp - model.minDayTemp) / weekTempDiff
            let maxOffset = abs(model.maxTemp - model.maxDayTemp) / weekTempDiff
            
            tempLimitsView.snp.remakeConstraints { make in
                make.trailing.equalToSuperview().multipliedBy(1 - maxOffset)
                make.height.equalToSuperview()
                make.width.equalToSuperview().multipliedBy(1 - minOffset - maxOffset)
            }
            
            if let currentTemp = model.currentTemp {
                let currentTempOffset = abs(model.minTemp - currentTemp) / weekTempDiff
                
                if currentTempOffset == 0 {
                    currentTempView.snp.remakeConstraints { make in
                        make.centerX.equalTo(snp.leading)
                        make.size.equalTo(snp.height)
                    }
                } else {
                    currentTempView.snp.remakeConstraints { make in
                        make.centerX.equalTo(snp.trailing).multipliedBy(currentTempOffset)
                        make.size.equalTo(snp.height)
                    }
                }
            }
        }
        
        //  MARK: - Private Methods
        private func setupView() {
            backgroundColor = .darkBlue.withAlphaComponent(0.5)
            layer.cornerRadius = 3
            
            snp.makeConstraints { make in
                make.height.equalTo(6)
            }
        }
        
        private func setupTempLimitsView() {
            addSubview(tempLimitsView)
            tempLimitsView.backgroundColor = .darkYellow
            tempLimitsView.layer.borderColor = UIColor.darkBlue.withAlphaComponent(0.7).cgColor
            tempLimitsView.layer.borderWidth = 1
            tempLimitsView.layer.cornerRadius = 3
            
            tempLimitsView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.height.equalToSuperview()
            }
        }
        
        private func setupCurrentTempView() {
            addSubview(currentTempView)
            currentTempView.backgroundColor = .white
            currentTempView.layer.borderColor = UIColor.darkBlue.withAlphaComponent(0.7).cgColor
            currentTempView.layer.borderWidth = 1
            currentTempView.layer.cornerRadius = 3
            
            currentTempView.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.size.equalTo(snp.height)
            }
        }
    }

}
