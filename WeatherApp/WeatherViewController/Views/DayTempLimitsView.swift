//
//  DayTempLimitsView.swift
//  WeatherApp
//
//  Created by Arsalan on 07.05.2024.
//

import UIKit
import SnapKit

final class DayTempLimitsView: UIView {
    
    //  MARK: - Data Model
    struct DataModel {
        let minWeekTemp: Double
        let maxWeekTemp: Double
        let minDayTemp: Double
        let maxDayTemp: Double
        let currentTemp: Double?
    }
    
    //  MARK: - Properties
    private let tempLimitsView = UIView()
    private let currentTempView = UIView()
    
    //  MARK: - Initialisation
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
    func setup(_ model: DataModel) {
        let weekTempDiff = model.maxWeekTemp - model.minWeekTemp
        let minOffset = abs(model.minWeekTemp - model.minDayTemp) / weekTempDiff
        let maxOffset = abs(model.maxWeekTemp - model.maxDayTemp) / weekTempDiff
        
        tempLimitsView.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().multipliedBy(1 - maxOffset)
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(1 - minOffset - maxOffset)
        }
        
        if let currentTemp = model.currentTemp {
            let currentTempOffset = abs(model.minWeekTemp - currentTemp) / weekTempDiff
            
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
        backgroundColor = UIColor(named: "darkBlue")?.withAlphaComponent(0.5)
        layer.cornerRadius = 3
        
        snp.makeConstraints { make in
            make.height.equalTo(6)
        }
    }
    
    private func setupTempLimitsView() {
        addSubview(tempLimitsView)
        tempLimitsView.backgroundColor = .darkYellow
        tempLimitsView.layer.borderColor = UIColor(named: "darkBlue")?.withAlphaComponent(0.7).cgColor
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
        currentTempView.layer.borderColor = UIColor(named: "darkBlue")?.withAlphaComponent(0.7).cgColor
        currentTempView.layer.borderWidth = 1
        currentTempView.layer.cornerRadius = 3
        
        currentTempView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.size.equalTo(snp.height)
        }
    }  
}
