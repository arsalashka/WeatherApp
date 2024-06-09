//
//  WeatherViewHeader.swift
//  WeatherApp
//
//  Created by Arsalan on 07.06.2024.
//

import UIKit
import SnapKit

final class WeatherViewHeader: UICollectionReusableView {
    //  MARK: - Properties
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    
    //  MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightBlue
        layer.cornerRadius = 16
        
        setupIconView()
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Public Methods
    func setup(imageSystemName: String, title: String, description: String?) {
        iconView.image = UIImage(
            systemName: imageSystemName)?.applyingSymbolConfiguration(.init(weight: .bold)
            )
        titleLabel.text = title.uppercased()
    }
    
    //  MARK: - Private Methods
    private func setupIconView() {
        addSubview(iconView)
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .white.withAlphaComponent(0.5)
        
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        titleLabel.textColor = .white.withAlphaComponent(0.5)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(8)
            make.verticalEdges.equalToSuperview().inset(12)
        }
    }
}
