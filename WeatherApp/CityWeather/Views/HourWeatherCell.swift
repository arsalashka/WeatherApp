//
//  HourlyWeatherCell.swift
//  WeatherApp
//
//  Created by Arsalan on 31.05.2024.
//

import UIKit
import SnapKit


final class HourlyWeatherCell: UICollectionViewCell {
    // MARK: Properties
    private let hourLabel = UILabel()
    private let iconView = UIImageView()
    private let tempLabel = UILabel()

    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
  
        setupHourLabel()
        setupIconView()
        setupTempLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public methods
    func setup(_ model: DayHourlyViewData) {
        hourLabel.text = model.title
        iconView.image = UIImage(systemName: model.imageSystemName ?? SFSymbolIdentifier.sunFill.rawValue)?
                            .withRenderingMode(.alwaysOriginal)
        tempLabel.text = model.temp
    }
    
    // MARK: Private Methods
    private func setupHourLabel() {
        addSubview(hourLabel)
        hourLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        hourLabel.textAlignment = .center
        hourLabel.textColor = .white

        hourLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }

    private func setupIconView() {
        addSubview(iconView)
        iconView.contentMode = .scaleAspectFit

        iconView.snp.makeConstraints { make in
            make.top.equalTo(hourLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.size.equalTo(25)
        }
    }

    private func setupTempLabel() {
        addSubview(tempLabel)
        tempLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        tempLabel.textAlignment = .center
        tempLabel.textColor = .white

        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
        }
    }
}
